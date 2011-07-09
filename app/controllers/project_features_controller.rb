class ProjectFeaturesController < ApplicationController
  load_and_authorize_resource :class => "Feature"
  check_authorization
  
  
  def index
    @project = Project.find(params[:project_id])
    respond_with(@project, :layout => (!pjax? && "features"))
  end
  
end
