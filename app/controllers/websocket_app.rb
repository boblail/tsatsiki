require 'rack/websocket'
require 'cucumber'

class WebsocketApp < Rack::WebSocket::Application
  
  
  def self.call(env)
    self.new.call(env)
  end
  
  def self.connections
    (@connections ||= [])
  end
  
  def connections
    self.class.connections
  end
  
  def connection
    websocket_handler
  end
  
  
  
  
  def on_open(env)
    connections.push(connection) unless connections.member?(connection)
    puts Rails.logger.debug "Client connected (#{connections.length} connections)"
  end
  
  def on_close(env)
    connections.delete(connection)
    puts Rails.logger.debug "Client disconnected (#{connections.length} connections)"
  end
  
  def on_error(env, error)
    puts Rails.logger.error "Error occured: " + error.message
  end
  
  def on_message(env, raw_message)
    json = JSON.parse(raw_message)
    message = json['message']
    data = json['data']
    
    case message
    when 'execute':                         on_execute(data)
    when 'hello':                           on_hello(data)
    when 'started', 'finished', 'result':   relay_message(message, raw_message)
    else
      puts Rails.logger.error "Unrecognized message \"#{message}\""
    end
  end
  
  
  
private
  
  
  
  def on_hello(params)
    puts "[hello] #{params.inspect}"
    
    send_message('hi')
  end
  
  
  def on_execute(params)
    puts "[execute] #{params.inspect}"
    
    project         = Project.find params['project_id'].to_i
    formatter       = 'Tsatsiki::Cucumber::Formatter'
    formatter_path  = File.join(Rails.root, 'lib', 'tsatsiki', 'cucumber', 'formatter.rb')
    tsatsiki_url    = "ws://localhost:3000/socket"
    command         = "cucumber-tsatsiki TSATSIKI_URL=#{tsatsiki_url} TSATSIKI_PROJECT_ID=#{project.id}"
    
    # fork do 
    #   with_clean_env do
    #     exec("cd #{project.path} && #{command}")
    #   end
    # end
    with_clean_env do
      process = ChildProcess.new("cd #{project.path} && #{command}")
      process.io.inherit!
      process.start
    end
  end
  
  
  
  # c.f. http://spectator.in/2011/01/28/bundler-in-subshells/
  # c.f. https://github.com/carlhuda/bundler/issuesearch?state=open&q=with_clean_env#issue/900
  
  BUNDLER_VARS = %w(BUNDLE_GEMFILE RUBYOPT BUNDLE_BIN_PATH)
  
  def with_clean_env
    bundled_env = ENV.to_hash
    BUNDLER_VARS.each{ |var| ENV.delete(var) }
    yield
  ensure
    ENV.replace(bundled_env.to_hash)
  end
  
  
  
  
  def send_message(message, data=nil)
    send_data_to_all({
      :message => message,
      :data => data
    }.to_json)
  end
  
  def relay_message(message, data)
    puts Rails.logger.info "[#{message}] relaying #{data}"
    send_data_to_all(data)
  end
  
  def send_data_to_all(data)
    connections.each do |connection|
      connection.send_data(data)
    end
  end
  
  
end
