class ProjectsController < ApplicationController
  load_and_authorize_resource
  check_authorization
  layout "application"
  
  
  
  def index
    redirect_to root_url
  end
  
  
  
  def show
    redirect_to project_features_path(:project_id => params[:id])
  end
  
  
  
  def new
    @project = Project.new
    respond_with(@project)
  end
  
  
  
  def edit
    @project = Project.find(params[:id])
    @users = User.all
    respond_with(@project, :layout => "project")
  end
  
  
  
  def create
    @project = current_user.projects.build(params[:project])
    @project.save
    respond_with(@project)
  end
  
  
  
  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    respond_with(@project)
  end
  
  
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_with(@project)
  end
  
  
  
end
