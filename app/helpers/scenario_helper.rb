module ScenarioHelper
  
  
  
  def render_scenarios(scenarios, options={})
    return "" if scenarios.empty?
    
    ul_options = options.pick(:id).merge(:class => "scenarios")
    content_tag(:ul, ul_options) do
      render(:partial => "projects/scenario", :collection => scenarios, :locals => {:options => options})
    end
  end
  
  
  
  def scenario_class(scenario)
    css = %w{scenario unknown}
    css.concat scenario.tags.map {|tag| "tag-#{tag}"}
    css.push("completed") if scenario.completed?
    css.push("empty") if scenario.empty?
    css.join(" ")
  end
  
  
  
  def scenario_tags(scenario)
    scenario.tags.empty? ? nil : scenario.tags.join(' ')
  end
  
  
  
  def scenario_icons(scenario)
    scenario.tags.map {|tag| scenario_icon_for(tag) }.compact.join.html_safe
  end
  
  def scenario_icon_for(tag)
    explanation = KNOWN_TAGS[tag]
    explanation && image_tag("icons/#{explanation[0]}", :class => "icon", :height => 14, :width => 14, :alt => explanation[1], :title => explanation[1])
  end
  
  
  
  def render_tag(tag)
    explanation = KNOWN_TAGS[tag]
    explanation && "<p class=\"scenario-tag tag-#{tag}\">#{explanation[1]}</p>".html_safe
  end
  
  
  
  def colorize_step(step)
    table_for_escape = {'&' => '&amp;', '<' => '&lt;', '>' => '&gt;'}
    step.gsub(/[&<>]/) {|match| table_for_escape[match]} \
        .gsub(/("[^"]*?")/, '<em>\1</em>') \
        .html_safe
  end
  
  
  
  # !todo: there's still duplication between the images here and those in images.scss.erb
  KNOWN_TAGS = {
    "human"       => ["user.png",             "This feature must be tested manually"],
    "javascript"  => ["script_code.png",      "This feature requires JavaScript"],
    "new"         => ["page_white_edit.png",  "This is a new feature"],
    "todo"        => ["page_white_edit.png",  "This feature is not yet implemented"],
    "wip"         => ["page_white_edit.png",  "This feature is not yet implemented"]
  }
  
  
  
end
