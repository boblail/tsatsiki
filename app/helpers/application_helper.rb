module ApplicationHelper
  
  
  def within_layout(layout, &block)
    # putting capture(&block) into a string is a way of making it an unsafe
    # string. This is a workaround for the error "Cannot modify SafeBuffer in place"
    html = "#{capture(&block)}"
    render(:inline => html, :layout => "layouts/#{layout}")
  end
  
  
end
