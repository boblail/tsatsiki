class ProjectTestPlanController < ApplicationController
  load_and_authorize_resource :class => "Feature"
  check_authorization
  layout "print"
  
  
  def show
    @project = Project.find(params[:project_id])
    @features = @project.features
  end
  
  
end
