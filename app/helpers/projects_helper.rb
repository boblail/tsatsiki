module ProjectsHelper
  
  def scenario_class(scenario)
    css = %w{scenario unknown}
    css.concat scenario.tags.map {|tag| "tag-#{tag[1..-1]}"}
    css.join(' ')
  end
  
  def scenario_tags(scenario)
    scenario.tags.empty? ? nil : scenario.tags.join(' ')
  end
  
  def render_scenarios(scenarios)
    "<ul class=\"tree scenarios\">#{render(:partial => "scenario", :collection => scenarios)}</ul>".html_safe
  end 
  
  def render_features(features)
    "<ul class=\"tree features\">#{render(:partial => "feature", :collection => features)}</ul>".html_safe
  end
  
  def render_steps(steps)
    "<ul class=\"scenario-steps\">#{render(:partial => "step", :collection => steps)}</ul>".html_safe
  end
  
end
