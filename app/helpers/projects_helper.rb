require 'cucumber'

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
    "<li>#{scenario[3]}</li>"
  end
  
end