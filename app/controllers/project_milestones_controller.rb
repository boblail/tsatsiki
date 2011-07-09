class ProjectMilestonesController < ApplicationController
  uses_freight_train
  
  load_and_authorize_resource :class => "Milestone"
  check_authorization
  
  has_actions_for Milestone, :belongs_to => :@project
  before_filter :find_project
  
  
  
  def index
    @milestones = @project.milestones
    render :layout => (!pjax? && "project")
  end
  
  
  
private
  
  def find_project
    @project = Project.find(params[:project_id])
  end
  
end
