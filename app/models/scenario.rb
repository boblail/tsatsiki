# sexp Pattern
#
#   [:scenario, line, keyword, text, *children]
#
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
    eval_children(sexp[4..-1])
  end
  
  
  
  attr_reader   :feature,
                :line,
                :comments,
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
    comments.each do |comment|
      output << "  #{comment}\n"
    end
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
    @tags     = []
    @steps    = []
    @comments = []
    
    children.each do |child|
      if    tag?(child);      @tags << child[1]
      elsif step?(child);     @steps << Step.new(self, child)
      elsif comment?(child);  @comments.concat child[1].split($/)
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