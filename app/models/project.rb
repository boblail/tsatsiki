class Project < ActiveRecord::Base
  
  
  
  def path_to_features
    File.join(self.path, 'features')
  end
  
  def features
    @features ||= Category.get_features(self, self.path_to_features)
  end
  
  def feature_count
    @feature_count = features.inject(0) {|sum, feature| sum + feature.scenarios.count}
  end
  
  def find_feature(relative_path)
    absolute_path = File.join(self.path, relative_path)
    File.exists?(absolute_path) ? Feature.new(self, absolute_path) : nil
  end
  
  
  
end
