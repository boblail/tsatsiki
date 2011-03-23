class Project < ActiveRecord::Base
  
  
  
  def path_to_features
    File.join(self.path, 'features')
  end
  
  def features
    @features ||= Dir.glob(File.join(self.path_to_features, '**/*.feature')).map {|path| Feature.new(self, path)}
  end
  
  
  
end
