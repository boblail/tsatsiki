fork do
  Kernel.exec "#{Rails.root.join('script', 'websocket-server')} start"
end
