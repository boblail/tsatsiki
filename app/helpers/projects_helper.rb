module ProjectsHelper
  
  #
  # sexp Examples
  #
  #   Feature:  [:feature,         file,          text, children]
  #   Scenario: [:scenario,        line, keyword, text, children]
  #   Step:     [:step_invocation, line, keyword, text          ]
  #
  def render_scenarios(scenarios)
    html = scenarios.inject("") {|html, scenario| scenario?(scenario) ? (html << render_scenario(scenario)) : html}
    html.blank? ? html : "<ul>#{html}</ul>".html_safe
  end
  
  def scenario?(sexp)
    sexp.is_a?(Array) && (sexp.first == :scenario)
  end
  
  def render_scenario(scenario)
    "<li class=\"scenario unknown\" data-line=\"#{scenario[1]}\">#{scenario[3]}</li>"
  end
  
  
  
  def render_features(features)
    "<ul>#{render(:partial => "feature", :collection => features)}</ul>".html_safe
  end
  
end
