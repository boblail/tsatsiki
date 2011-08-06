fork do
  Kernel.exec "#{Rails.root.join('script', 'ws')} start"
end
