require 'bundler'
require 'eventmachine'
require 'em-websocket'
require 'childprocess'
require 'json'
require 'active_record'
require File.join(File.dirname(__FILE__), 'bundler_backport.rb')



RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined?(RAILS_ROOT)
Dir.chdir(RAILS_ROOT)



class WebsocketServer
  class << self
    
    
    
    def run
      load_configuration
      load_project_model
      
      EM.run do
        @channel = EM::Channel.new
        @tsatsiki_url = "http://#{host}:#{port}"
        @cucumber_processes = []
        params = {:host => host, :port => port}
        
        EM::WebSocket.start(params) do |ws|
          
          
          
          def ws.send_json(o)
            send(o.to_json)
          end
          
          def ws.send_message(message, data=nil)
            send_json({
              :message => message,
              :data => data
            })
          end
          
          def ws.send_error(message)
            send_message("error", message)
          end
          
          
          
          ws.onopen do
            puts "[tsatsiki] client connected"
            
            sid = @channel.subscribe do |msg|
              ws.send(msg)
            end
            
            ws.onclose do
              puts "[tsatsiki] client disconnected"
              @channel.unsubscribe(sid)
            end
            
            ws.onerror do |*args|
              puts "[tsatsiki] error: #{args.inspect}"
              ws.send_error(args.inspect)
            end
            
            ws.onmessage do |raw_message|
              json = JSON.parse(raw_message)
              message = json['message']
              data = json['data']
              
              case message
              when 'execute'
                ws.on_execute(@cucumber_processes, @tsatsiki_url, data)
              when 'hello', 'started', 'finished', 'result'
                @channel.push(raw_message)
              else
                puts "[tsatsiki] unrecognized message: \"#{message}\""
              end
            end
            
          end
          
          
          
          def ws.on_execute(cucumber_processes, tsatsiki_url, params)
            puts "[execute] #{params.inspect}"
            
            formatter_path = File.join(RAILS_ROOT, "lib", "tsatsiki", "cucumber")
            project = Project.find params['project_id'].to_i
            
            command = "cucumber"
            command = "bundle exec #{command}" if project.uses_bundler?
            
            # This is the formatter that sends result back to the WebSocket server
            command << " --format Tsatsiki::Cucumber::Formatter"
            command << " --require \"#{formatter_path}\""
            
            # When using the --require option, automatic requirement is disabled and
            # the default support path must be manually required
            command << " --require ./features"
            
            # Don't execute the following tags
            command << " --tags ~@human"
            command << " --tags ~@tsatsiki-ignore"
            command << " --tags ~@javascript" unless project.execute_javascript_scenarios?
            
            # Parameters that must be passed to Tsatsiki::Cucumber::Formatter
            command << " TSATSIKI_URL=#{tsatsiki_url}"
            command << " TSATSIKI_PROJECT_ID=#{project.id}"
            
            # Why isn't RAILS_ENV being set to test?
            command << " RAILS_ENV=test"
            
            # rvmrc = File.join(project.path, ".rvmrc")
            # if File.exists?(rvmrc)
            #   command = File.read(rvmrc).strip + " && " + command
            # end
            
            command = "cd #{project.path} && #{command}"
            
            puts "[execute] #{command}"
            pid = fork { Bundler.clean_exec(command) }
            Process.detach(pid)
            cucumber_processes << {
              :project_id => project.id,
              :pid => pid
            }
          end
          
          
          # Make sure that when the process dies, the client gets notified
          EM.add_periodic_timer(1) do
            @cucumber_processes.dup.each do |process|
              unless process_running?(process[:pid])
                puts "dead!"
                @cucumber_processes.delete(process)
                ws.send_message('finished', {:project_id => process[:project_id]})
              end
            end
          end
          
          
        end
        
        
      end
    end
    
    
    
    attr_reader :host, :port
    
    
    
  private
    
    
    
    def process_running?(pid)
      Process.kill 0, pid
      true
    rescue Errno::ESRCH
      false
    end
    
    
    
    def load_project_model
      config = read_config_yml("database.yml")
      ActiveRecord::Base.establish_connection(config)
      require File.join(RAILS_ROOT, 'app', 'models', 'project')
    end
    
    def load_configuration
      config = read_config_yml("websocket.yml")
      @host = config["host"]
      @port = config["port"]
    end
    
    def environment
      ENV["RAILS_ENV"] || "development"
    end
    
    def read_config_yml(file)
      path = File.join(RAILS_ROOT, 'config', file)
      YAML::load(File.open(path))[environment]
    end
    
    
    
  end
end



WebsocketServer.run
