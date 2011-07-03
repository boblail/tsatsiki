module UrlHelper
  
  
  
  def socket_url(options={})
    options[:protocol] = "ws"
    "#{root_url(options)}socket"
  end
  
  
  
  def scenario_path(scenario, options={})
    super(options.merge({
      :project_id => scenario.project_id,
      :feature    => scenario.feature.path,
      :index      => scenario.index
    }))
  end
  
  def edit_scenario_path(scenario, options={})
    super(options.merge({
      :project_id => scenario.project_id,
      :feature    => scenario.feature.path,
      :index      => scenario.index
    }))
  end
  
  
  def new_scenario_path(feature, options={})
    super(options.merge({
      :project_id => feature.project_id,
      :feature    => feature.path
    }))
  end
  
  def scenarios_path(feature, options={})
    super(options.merge({
      :project_id => feature.project_id,
      :feature    => feature.path
    }))
  end
  
  
  
end