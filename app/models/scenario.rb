class Scenario
  
  
  
  # sexp Examples
  #
  #   Feature:  [:feature,         file,          text,         children]
  #   Scenario: [:scenario,        line, keyword, text, (tags), children]
  #   Step:     [:step_invocation, line, keyword, text          (table)]
  #
  def initialize(feature, sexp)
    @feature = feature
    @line = sexp[1]
    @name = sexp[3]
    children = sexp[4..-1]
    eval_children(children)
  end
  
  
  
  attr_reader   :feature,
                :line,
                :tags,
                :steps
  attr_accessor :name
  
  def path
    "/#{feature.relative_path}/#{line}"
  end
  
  def ==(other)
    other && self.path == other.path
  end
  
  
  
  def render
    output = "\n\n"
    tags.each do |tag|
      output << "  #{tag}\n"
    end
    output << "  Scenario: #{name}\n"
    steps.each do |step|
      output << step.render
    end
    output
  end
  
  
  
private
  
  
  
  def eval_children(children)
    @tags  = []
    @steps = []
    
    children.each do |child|
      if    tag?(child);      @tags << child[1]
      elsif step?(child);     @steps << Step.new(self, child)
      elsif comment?(child);  # Do nothing
      else;                   raise("unrecognized sexp: #{child.first}")
      end
    end
  end
  
  def tag?(sexp)
    sexp.first == :tag
  end
  
  def step?(sexp)
    sexp.first == :step_invocation
  end
  
  def comment?(sexp)
    sexp.first == :comment
  end
  
  
  
end