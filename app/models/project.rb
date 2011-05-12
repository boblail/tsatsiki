class Project < ActiveRecord::Base
  
  
  
  def path_to_features
    File.join(self.path, 'features')
  end
  
  def features
    @features ||= Category.get_features(self, self.path_to_features)
  end
  
  
  
end
