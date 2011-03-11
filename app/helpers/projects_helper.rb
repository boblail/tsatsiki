require 'cucumber'

module ProjectsHelper
  
  def render_feature(file)
    ast = Cucumber::FeatureFile.new(file).parse([], {})
    sexp = ast.to_sexp
    render_sexp(sexp)
  end
  
  #
  # sexp Examples
  #
  #   Feature:  [:feature,         file,          text, children]
  #   Scenario: [:scenario,        line, keyword, text, children]
  #   Step:     [:step_invocation, line, keyword, text          ]
  #
  def render_sexp(sexp)
    html = "<dl><dt>" << sexp.shift.to_s << "</dt><dd>"
    sexp.each do |item|
      html << (item.is_a?(Array) ? render_sexp(item) : "#{item}<br />")
    end
    html << "</dd></dl>"
    html.html_safe
  end
  
end
