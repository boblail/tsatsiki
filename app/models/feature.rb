# sexp Pattern
#
#   [:feature, path, text, *children]
#
class Feature
  
  
  
  def initialize(project, absolute_path)
    @project = project
    @absolute_path = absolute_path
    @relative_path = Pathname.new(absolute_path).relative_path_from(Pathname.new(@project.path))
  end
  
  
  
  attr_reader :project,
              :absolute_path,
              :relative_path
  alias :path :relative_path
  
  def project_id
    project.id
  end
  
  def self.parse_file!(path)
    parse!(nil, path)
  end
  
  def self.parse!(source, path=nil)
    Cucumber::FeatureFile.new(path, source).parse([], {}).to_sexp
  end
  
  def sexp
    @sexp ||= Feature.parse_file!(self.absolute_path)
  end
  
  def name
    parse_sexp
    @name
  end
  
  def background
    parse_sexp
    @background || ""
  end
  
  def scenarios
    parse_sexp
    @scenarios
  end
  
  def comments
    parse_sexp
    @comments
  end
  
  def ==(other)
    other.is_a?(Feature) && self.absolute_path == other.absolute_path
  end
  
  
  
  def write!
    rendered_feature = self.render
    File.open(absolute_path, "w") {|f| f.write(rendered_feature)}
  end
  
  def render
    output = ""
    comments.each do |comment|
      output << "#{comment}\n"
    end
    output << "Feature: #{name}\n"
    background.split($/).each do |line|
      output << "  #{line}\n"
    end
    scenarios.each do |scenario|
      output << "  \n  \n"
      output << scenario.render
    end
    output
  end
  
  
  
private
  
  
  
  def parse_sexp
    unless @name
      @name, @background = sexp[2].split($/, 2)
      eval_children(sexp[3..-1])
    end
  end
  
  def eval_children(children)
    @scenarios = []
    @comments = []
    
    children.each do |child|
      if    scenario?(child);   @scenarios << Scenario.new(self, @scenarios.length + 1, child)
      elsif comment?(child);    @comments.concat child[1].split($/)
      else;                     raise("unrecognized sexp: #{child.first}")
      end
    end
  end
  
  def scenario?(sexp)
    (sexp.first == :scenario) || (sexp.first == :scenario_outline)
  end
  
  def comment?(sexp)
    sexp.first == :comment
  end
  
  
  
end
    