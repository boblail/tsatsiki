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
    "<ul class=\"scenarios\">#{render(:partial => "projects/scenario", :collection => scenarios)}</ul>".html_safe
  end
  
  def render_features(features)
    "<ul class=\"tree features\">#{render(:partial => "projects/feature", :collection => features)}</ul>".html_safe
  end
  
  def render_tag(tag)
    tag = tag[1..-1] # remove the '@'
    case tag
    when "human"
      "<p class=\"scenario-tag tag-human\">This feature must be tested manually</p>".html_safe
    when "javascript"
      "<p class=\"scenario-tag tag-javascript\">This feature requires JavaScript</p>".html_safe
    when "wip", "todo"
      "<p class=\"scenario-tag tag-todo\">This feature is not yet implemented</p>".html_safe
    end
  end
  
  def known_tag?(tag)
    %w{human javascript}.member?(tag)
  end
  
  def colorize_step(step)
    table_for_escape = {'&' => '&amp;', '<' => '&lt;', '>' => '&gt;'}
    step.gsub(/[&<>]/) {|match| table_for_escape[match]} \
        .gsub(/("[^"]*?")/, '<em>\1</em>') \
        .html_safe
  end
  
  # def render_steps(steps)
  #   "<ul class=\"scenario-steps\">#{render(:partial => "step", :collection => steps)}</ul>".html_safe
  # end
  
end
