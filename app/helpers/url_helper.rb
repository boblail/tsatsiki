module UrlHelper
  
  
  
  def socket_url(options={})
    options[:protocol] = "ws"
    "#{root_url(options)}socket"
  end
  
  
  
end