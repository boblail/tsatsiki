module FeatureHelper
  
  
  
  def render_features(features, options={})
    return "" if features.empty?
    
    ul_options = {:class => "tree features"}
    ul_options.merge!(:id => options.delete(:id)) if options.key?(:id)
    content_tag(:ul, ul_options) do
      render(:partial => "projects/feature", :collection => features, :locals => {:options => options})
    end
  end
  
  
  
end