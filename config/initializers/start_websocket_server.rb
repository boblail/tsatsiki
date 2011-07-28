require 'websocket_server'

begin
  
  server = WebsocketServer.new
  server.start!
  
  at_exit do
    server.kill
  end
  
rescue WebsocketServer::FailedToStart
  
  Rails.logger.error "websocket server failed to start"
  
end