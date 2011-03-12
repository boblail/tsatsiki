require 'rack/websocket'

class WebsocketApp < Rack::WebSocket::Application
  
  ACCEPTED_MESSAGES = %w{hello execute}
  
  
  def self.call(env)
    self.new.call(env)
  end
  
  
  def on_open
    Rails.logger.debug "Client connected"
  end
  
  def on_close
    Rails.logger.debug "Client disconnected"
  end
  
  def on_error(error)
    Rails.logger.error "Error occured: " + error.message
  end
  
  def on_message(json)
    json = JSON.parse(json)
    message = json['message']
    data = json['data']
    if valid_message?(message)
      send("on_#{message}", data)
    else
      Rails.logger.error "Unrecognized message \"#{message}\""
    end
  end
  
  
  def send_message(message, data=nil)
    send_data({
      :message => message,
      :data => data
    }.to_json)
  end
  
  
private
  
  
  def valid_message?(message)
    ACCEPTED_MESSAGES.member?(message)
  end
  
  
  def on_hello
    send_message('hi')
  end
  
  
  def on_execute(params)
    send_message('ok')
  end
  
  
end
