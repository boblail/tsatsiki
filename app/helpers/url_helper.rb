module UrlHelper
  
  
  
  def socket_url(options={})
    options[:protocol] = "ws"
    "#{root_url(options)}socket"
  end
  
  
  
  def scenario_path(scenario, options={})
    "#{root_url(options)}projects/#{scenario.feature.project.id}/features/#{scenario.feature.path}/#{scenario.index}"
  end
  
  
  
end