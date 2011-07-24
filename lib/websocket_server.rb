require "childprocess"
require 'socket'
require 'timeout'


class WebsocketServer
  
  def start!
    unless self.process || is_port_open?("127.0.0.1", 8080)
      puts "[tsatsiki] starting websocket server..."
      self.process = ChildProcess.new(executer_path)
      self.process.io.inherit!
      self.process.start
      sleep 0.5
      raise("Not Running!") unless self.process.alive?
    end
  end
  
  def kill
    if self.process
      puts "[tsatsiki] killing websocket server..."
      self.process.stop if self.process.alive?
      self.process = nil
      sleep 0.5
    end
  end
  
protected
  
  attr_accessor :process
  
  def executer_path
    @executer_path ||= File.expand_path(File.join(File.dirname(__FILE__), "../script/websocket-server"))
  end
  
  def is_port_open?(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      end
    rescue Timeout::Error
    end
    
    return false
  end
  
end
