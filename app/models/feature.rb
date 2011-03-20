class Feature
  
  def initialize(project, absolute_path)
    @project = project
    @absolute_path = absolute_path
    @relative_path = Pathname.new(absolute_path).relative_path_from(Pathname.new(@project.path))
  end
  
  attr_reader :absolute_path, :relative_path
  
  def sexp
    @sexp ||= Cucumber::FeatureFile.new(self.absolute_path).parse([], {}).to_sexp
  end
  
  def name
    sexp[2][/.*$/]
  end
  
  def scenarios
    sexp[3..-1]
  end
  
end
    