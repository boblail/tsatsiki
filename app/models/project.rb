class Project < ActiveRecord::Base
  
  
  
  def path_to_features
    File.join(self.path, 'features')
  end
  
  def features
    @features ||= Feature.get_features(self, self.path_to_features)
  end
  
  def scenarios
    @scenarios ||= features.inject([]) {|all, feature| all.concat(feature.all_scenarios)}
  end
  
  def find_feature(relative_path)
    find_feature_in_array(features, relative_path)
  end
  
  
  
private
  
  
  
  def find_feature_in_array(features, relative_path)
    features.each do |feature|
      return feature if feature.relative_path == relative_path
      subfeature = find_feature_in_array(feature.features, relative_path)
      return subfeature if subfeature
    end
    nil
  end
  
  
  
end
