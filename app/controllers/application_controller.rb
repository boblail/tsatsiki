class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html
  
protected
  
  def pjax?
    params[:_pjax] == "true"
  end
  
end
