module TestPlanHelper
  
  
  def with_each_leaf_feature(features, ancestors=[], &block)
    features.each do |feature|
      if feature.scenarios.any? {|s| s.completed? && s.human?}
        block.call(ancestors, feature)
      end
      with_each_leaf_feature(feature.features, (ancestors + [feature]), &block)
    end
  end
  
  
end
