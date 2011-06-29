module ApplicationHelper
  
  
  def within_layout(layout, &block)
    html = capture(&block)
    render(:inline => html, :layout => "layouts/#{layout}")
  end
  
  
end
