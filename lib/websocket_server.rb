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
  
  
  
  def self.run(host, port)
    load_project_model
    
    EM.run do
      @channel = EM::Channel.new
      @tsatsiki_url = "http://#{host}:#{port}"
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
              ws.on_execute(@tsatsiki_url, data)
            when 'hello', 'started', 'finished', 'result'
              @channel.push(raw_message)
            else
              puts "[tsatsiki] unrecognized message: \"#{message}\""
            end
          end
          
        end
        
        
        
        def ws.on_execute(tsatsiki_url, params)
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
          fork { Bundler.clean_exec(command) }
        end
        
        
        
      end
    end
  end
  
  
  
  def self.load_project_model
    environment = ENV["RAILS_ENV"] || "development"
    database_yml = YAML::load(File.open(File.join(RAILS_ROOT, 'config', 'database.yml')))
    config = database_yml[environment]
    
    ActiveRecord::Base.establish_connection(config)
    
    require File.join(RAILS_ROOT, 'app', 'models', 'project')
    
  end
  
  
  
end



WebsocketServer.run("127.0.0.1", 8080)
