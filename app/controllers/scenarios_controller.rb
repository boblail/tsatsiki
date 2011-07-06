class ScenariosController < ApplicationController
  load_and_authorize_resource
  check_authorization
  before_filter :find_scenario
  include UrlHelper
  
  
  
  def show
    if @selected_scenario
      render :layout => (!pjax? && "project")
    else
      flash[:notice] = "The feature you were looking for was not found"
      redirect_to project_path(@project)
    end
  end
  
  def new
    render :layout => (!pjax? && "project")
  end
  
  def edit
    render :layout => (!pjax? && "project")
  end
  
  
  
  def create
    @selected_scenario.update_attributes!(params[:scenario])
    if request.xhr?
      head :ok
    else
      redirect_to scenario_path(@selected_scenario)
    end
  rescue
    Rails.logger.error $!.to_s
    if request.xhr?
      head :unprocessable_entity
    else
      flash[:error] = $!.to_s
      redirect_to new_scenario_path(@feature)
    end
  end
  
  
  
  def update
    @selected_scenario.update_attributes!(params[:scenario])
    if request.xhr?
      head :ok
    else
      redirect_to scenario_path(@selected_scenario)
    end
  rescue
    Rails.logger.error $!.to_s
    if request.xhr?
      head :unprocessable_entity
    else
      flash[:error] = $!.to_s
      redirect_to edit_scenario_path(@selected_scenario)
    end
  end
  
  
  
  def destroy
    @selected_scenario.destroy!
    
    flash[:notice] = "The feature \"#{@selected_scenario.name}\" was removed."
    redirect_to project_path(@project)
  end
  
  
  
private
  
  
  
  def find_scenario
    @project           = Project.find(params[:project_id])
    @feature           = @project.find_feature(params[:feature])
    index              = params[:index].to_i - 1
    @selected_scenario = (index < 0) ? Scenario.new(@feature) : @feature.scenarios[index] if @feature
    
    unless @selected_scenario
      flash[:notice] = "The feature you were looking for could not be found."
      redirect_to project_url(@project)
    end
  end
  
  
  
end
