class HomeController < ApplicationController
  
  
  
  def index
    @projects = Project.all
    respond_with(@projects, :layout => "home")
  end
  
  
  
end
