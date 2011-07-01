# sexp Pattern
#
#   [:feature, path, text, children]
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
  
  def sexp
    @sexp ||= Cucumber::FeatureFile.new(self.absolute_path).parse([], {}).to_sexp
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
    @scenarios ||= sexp[3..-1].select(&method(:scenario?)).map {|scenario| Scenario.new(self, scenario)}
  end
  
  
  
  def write!
    rendered_feature = self.render
    File.open(absolute_path, "w") {|f| f.write(rendered_feature)}
  end
  
  def render
    output = ""
    output << "Feature: #{name}\n"
    background.split($/).each do |line|
      output << "  #{line}\n"
    end
    scenarios.each do |scenario|
      output << scenario.render
    end
    output
  end
  
  
  
private
  
  
  
  def parse_sexp
    @name, @background = sexp[2].split($/, 2) unless @name
  end
  
  
  def scenario?(*scenario)
    scenario.is_a?(Array) && (scenario.first == :scenario)
  end
  
  
  
end
    