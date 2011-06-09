class Category
  
  def self.get_features(project, absolute_path)
    features = []
    
    Dir.glob(File.join(absolute_path, '*/')).each do |path|
      category = Category.new(project, path)
      features << category unless category.features.empty?
    end
    
    Dir.glob(File.join(absolute_path, '*.feature')).each do |path|
      features << Feature.new(project, path)
    end
    
    features
  end
  
  def initialize(project, absolute_path)
    @project = project
    @absolute_path = absolute_path
    @name = File.basename(absolute_path).humanize
    @features = Category.get_features(project, absolute_path)
    @relative_path = Pathname.new(absolute_path).relative_path_from(Pathname.new(@project.path))
  end
  
  attr_reader :absolute_path,
              :relative_path,
              :features,
              :name
  
  def scenarios
    self.features.inject([]) {|all, feature| all.concat(feature.scenarios)}
  end
  
end
