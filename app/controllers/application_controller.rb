class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html
  
  layout :layout_by_resource
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  
protected
  
  
  def pjax?
    params[:_pjax] == "true"
  end
  
  
private
  
  
  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end
  
  
end
