# sexp Pattern
#
#   [:scenario, line,   keyword, text, *children]
#   [:scenario_outline, keyword, text, *children]
#
class Scenario
  
  
  
  def initialize(feature, index=nil, sexp=nil)
    sexp    ||= [:scenario, nil, "Scenario", "New Feature", [:tag, "@new"]]
    @feature  = feature
    @index    = index
    @type     = sexp[0]
    
    sexp.delete_at(1) if scenario? # Disregard line
    
    @name     = sexp[2]
    children  = sexp[3..-1]
    
    @tags     = []
    @steps    = []
    @comments = []
    @examples = nil
    eval_children(children)
  end
  
  
  
  attr_reader   :feature,
                :index,
                :type,
                :id,
                :comments,
                :tags,
                :steps,
                :examples
  attr_accessor :name,
                :milestone_version
  
  delegate      :project_id,
                :to => :feature
  
  def scenario?
    type == :scenario
  end
  
  def scenario_outline?
    type == :scenario_outline
  end
  
  def new_record?
    index.nil?
  end
  
  def body
    render_body.lines.map {|line| line[4..-1] }.join
  end
  
  def body=(body)
    sexp      = Scenario.parse_body!(body)
    @steps    = []
    @examples = nil
    eval_children(sexp)
  end
  
  def self.parse_body!(body)
    sexp = Feature.parse!("Feature: Context\nScenario: Context\n#{body}")
    sexp[3][4..-1]
  end
  
  def path
    "/#{feature.relative_path}/#{index}"
  end
  
  def ==(other)
    other && self.path == other.path
  end
  
  
  
  def update_attributes!(attributes)
    attributes.each {|key, value| send("#{key}=", value) }
    save!
  end
  
  def save!
    if new_record?
      feature.scenarios << self
      @index = feature.scenarios.length
    end
    feature.write!
  end
  
  
  
  def destroy!
    feature.scenarios.delete_at((index-1))
    feature.write!
  end
  
  
  
  def feature?
    true
  end
  
  def boundary?
    tags.member?("boundary")
  end
  
  def completed?
    !(new? || todo? || wip?) && !undefined?
  end
  
  def empty?
    steps.empty?
  end
  alias :undefined? :empty?
  
  def human?
    tags.member?("human")
  end
  
  def ignore?
    tags.member?("tsatsiki-ignore")
  end
  
  def new?
    tags.member?("new")
  end
  alias :proposed? :new?
  
  def todo?
    tags.member?("todo") || wip?
  end
  
  def wip?
    tags.member?("wip")
  end
  alias :started? :wip?
  
  
  
  def render
    output = ""
    comments.each do |comment|
      output << "  #{comment}\n"
    end
    tsatsiki_comments.each do |comment|
      output << "  #{comment}\n"
    end
    tags.each do |tag|
      output << "  @#{tag}\n"
    end
    output << "  @milestone=#{milestone_version}\n" if milestone_version
    output << "  Scenario: #{name}\n" if scenario?
    output << "  Scenario Outline: #{name}\n" if scenario_outline?
    output << render_body
    output
  end
  
  def render_body
    output = ""
    steps.each do |step|
      output << step.render
    end
    if examples
      output << "    Examples:\n"
      output << examples.render
    end
    output
  end
  
  
  
private
  
  
  
  def eval_children(children)
    children.each do |child|
      if    tag?(child);      eval_tag(child[1])
      elsif step?(child);     @steps << Step.new(self, child)
      elsif comment?(child);  child[1].split($/).each(&method(:eval_comment))
      elsif examples?(child); @examples = Table.new(child[3])
      else;                   raise("unrecognized sexp: #{child.first}")
      end
    end
  end
  
  def tag?(sexp)
    sexp.first == :tag
  end
  
  def step?(sexp)
    (sexp.first == :step_invocation) || (sexp.first == :step)
  end
  
  def comment?(sexp)
    sexp.first == :comment
  end
  
  def examples?(sexp)
    sexp.first == :examples
  end
  
  
  
  def eval_tag(tag)
    case tag
    when /^@milestone=(.*)$/;     @milestone_version = $1
    else;                         @tags << tag[1..-1] # remove the '@'
    end
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