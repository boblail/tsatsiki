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
    sexp[2][/.*$/]
  end
  
  def scenarios
    @scenarios ||= sexp[3..-1].select(&method(:scenario?)).map {|scenario| Scenario.new(self, scenario)}
  end
  
  
  
private
  
  
  
  def scenario?(*scenario)
    scenario.is_a?(Array) && (scenario.first == :scenario)
  end
  
  
  
end
    