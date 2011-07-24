require 'websocket_server'

server = WebsocketServer.new
server.start!

at_exit do
  server.kill
end
