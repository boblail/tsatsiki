class Project < ActiveRecord::Base
  
  
  
  def path_to_features
    File.join(self.path, 'features')
  end
  
  
  
end
