class Scenario
  
  #
  # sexp Examples
  #
  #   Feature:  [:feature,         file,          text,         children]
  #   Scenario: [:scenario,        line, keyword, text, (tags), children]
  #   Step:     [:step_invocation, line, keyword, text                  ]
  #
  def initialize(feature, sexp)
    @feature = feature
    @line = sexp[1]
    @name = sexp[3]
    children = sexp[4..-1]
    @tags = read_tags(children)
    @steps = read_steps(children)
  end
  
  attr_reader :feature, :line, :name, :tags, :steps
  
  
private
  
  
  def read_tags(children)
    children.select(&method(:tag?)).map {|sexp| sexp[1]}
  end
  
  def read_steps(children)
    children.select(&method(:step_invocation?))
  end
  
  
  def tag?(*args)
    args.first == :tag
  end
  
  def step_invocation?(*args)
    args.first == :step_invocation
  end
  
  
  
end