require 'rack/websocket'

class WebsocketApp < Rack::WebSocket::Application
  
  def self.call(env)
    self.new.call(env)
  end
  
  def on_open
    Rails.logger.debug "Client connected"
  end
  
  def on_close
    Rails.logger.debug "Client disconnected"
  end
  
  def on_message(message)
    case message
    when /hello/
      send_data({:key => "value"})
    when /cucumber/
      send_data({:key => "value"})
    end
  end
  
  def on_error(error)
    Rails.logger.error "Error occured: " + error.message
  end
  
end
