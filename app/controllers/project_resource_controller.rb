class ProjectResourceController < ApplicationController
  before_filter :find_project
  layout "project"
  
  
protected
  
  
  def find_project
    @project = Project.find(params[:project_id])
  end
  
  
end
