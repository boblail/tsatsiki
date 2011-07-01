# sexp Pattern
#
#   [:scenario, line, keyword, text, *children]
#
class Scenario
  
  
  
  def initialize(feature, sexp)
    @feature = feature
    @line = sexp[1]
    @name = sexp[3]
    eval_children(sexp[4..-1])
  end
  
  
  
  attr_reader   :feature,
                :id,
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
    tsatsiki_comments.each do |comment|
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
      elsif comment?(child);  child[1].split($/).each(&method(:eval_comment))
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
  
  
  
  TSATSIKI_PREFIX = "##/TSATSIKI "
  TSATSIKI_SUFFIX = "     ## This line was generated by Tsatsiki. DO NOT REMOVE"
  TSATSIKI_MATCHER = Regexp.new("#{TSATSIKI_PREFIX}(.*)#{TSATSIKI_SUFFIX}")
  
  def eval_comment(comment)
    if tsatsiki_comment?(comment)
      eval_tsatsiki_comment(comment)
    else
      @comments << comment
    end
  end
  
  def tsatsiki_comment?(comment)
    comment =~ TSATSIKI_MATCHER
  end
  
  def eval_tsatsiki_comment(comment)
    comment =~ TSATSIKI_MATCHER
    values = $1.split(', ')
    values.each do |value|
      case value
      when /scenario_id=(\d+)/;      @id = $1.to_i
      end
    end
  end
  
  
  
  def tsatsiki_comments
    comments = []
    comments << format_tsatsiki_comment("scenario_id=#{id}") if id
    comments
  end
  
  def format_tsatsiki_comment(comment)
    "#{TSATSIKI_PREFIX}#{comment}#{TSATSIKI_SUFFIX}"
  end
  
  
  
end