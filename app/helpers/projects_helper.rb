module ProjectsHelper
  
  def project_statistics(*names)
    names.map(&method(:project_statistic)).join.html_safe
  end
  
  def project_statistic(name)
    predicate = "#{name.to_s.singularize}?".to_sym
    html = \
    <<-HTML
    <li class="project-statistic">
      <a href="##{name}" class="toggle project-statistic-button">
        <span class="project-statistic-count">#{@project.scenarios.select(&predicate).count}</span>
        <span class="project-statistic-label">#{name.to_s.titleize}</span>
      </a>
    </li>
    HTML
    html.html_safe
  end
  
  def scenario_class(scenario)
    css = %w{scenario unknown}
    css.concat scenario.tags.map {|tag| "tag-#{tag[1..-1]}"}
    css.push("completed") if scenario.completed?
    css.push("empty") if scenario.empty?
    css.join(' ')
  end
  
  def scenario_tags(scenario)
    scenario.tags.empty? ? nil : scenario.tags.join(' ')
  end
  
  def render_scenarios(scenarios, options={})
    return "" if scenarios.empty?
    
    ul_options = options.pick(:id).merge(:class => "scenarios")
    content_tag(:ul, ul_options) do
      render(:partial => "projects/scenario", :collection => scenarios, :locals => {:options => options})
    end
  end
  
  def render_features(features, options={})
    return "" if features.empty?
    
    ul_options = options.pick(:id).merge(:class => "tree features")
    content_tag(:ul, ul_options) do
      render(:partial => "projects/feature", :collection => features, :locals => {:options => options})
    end
  end
  
  def render_tag(tag)
    tag = tag[1..-1] # remove the '@'
    case tag
    when "human"
      "<p class=\"scenario-tag tag-human\">This feature must be tested manually</p>".html_safe
    when "javascript"
      "<p class=\"scenario-tag tag-javascript\">This feature requires JavaScript</p>".html_safe
    when "new"
      "<p class=\"scenario-tag tag-new\">This is a new feature</p>".html_safe
    when "todo"
      "<p class=\"scenario-tag tag-todo\">This feature is not yet implemented</p>".html_safe
    when "wip"
      "<p class=\"scenario-tag tag-wip\">This feature is a work-in-progress</p>".html_safe
    end
  end
  
  def known_tag?(tag)
    %w{human javascript new}.member?(tag)
  end
  
  def colorize_step(step)
    table_for_escape = {'&' => '&amp;', '<' => '&lt;', '>' => '&gt;'}
    step.gsub(/[&<>]/) {|match| table_for_escape[match]} \
        .gsub(/("[^"]*?")/, '<em>\1</em>') \
        .html_safe
  end
  
  def project_features_class
    (request.path =~ /projects\/\d+\/features/) && "selected"
  end
  
  def edit_project_class
    (request.path =~ /projects\/\d+\/edit/) && "selected"
  end
  
  # def render_steps(steps)
  #   "<ul class=\"scenario-steps\">#{render(:partial => "step", :collection => steps)}</ul>".html_safe
  # end
  
end
