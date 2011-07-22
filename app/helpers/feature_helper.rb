module FeatureHelper
  
  
  
  def render_features(features, options={})
    return "" if features.empty?
    
    ul_options = options.pick(:id).merge(:class => "tree features")
    content_tag(:ul, ul_options) do
      render(:partial => "projects/feature", :collection => features, :locals => {:options => options})
    end
  end
  
  
  
end