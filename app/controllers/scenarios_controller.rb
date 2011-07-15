class ScenariosController < ApplicationController
  before_filter :find_scenario
  load_and_authorize_resource
  check_authorization
  include UrlHelper
  
  
  
  def show
    if @scenario
      render :layout => (!pjax? && "features")
    else
      flash[:notice] = "The feature you were looking for was not found"
      redirect_to scenarios_path(@project)
    end
  end
  
  def new
    render :layout => (!pjax? && "features")
  end
  
  def edit
    render :layout => (!pjax? && "features")
  end
  
  
  
  def create
    @scenario.update_attributes!(params[:scenario])
    if request.xhr?
      head :ok
    else
      redirect_to scenario_path(@scenario)
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
    @scenario.update_attributes!(params[:scenario])
    if request.xhr?
      head :ok
    else
      redirect_to scenario_path(@scenario)
    end
  rescue
    Rails.logger.error $!.to_s
    if request.xhr?
      head :unprocessable_entity
    else
      flash[:error] = $!.to_s
      redirect_to edit_scenario_path(@scenario)
    end
  end
  
  
  
  def destroy
    @scenario.destroy!
    
    flash[:notice] = "The feature \"#{@scenario.name}\" was removed."
    redirect_to project_path(@project)
  end
  
  
  
private
  
  
  
  def find_scenario
    @project  = Project.find(params[:project_id])
    @feature  = @project.find_feature(params[:feature])
    index     = params[:index].to_i - 1
    @scenario = (index < 0) ? Scenario.new(@feature) : @feature.scenarios[index] if @feature
    
    unless @scenario
      flash[:notice] = "The feature you were looking for could not be found."
      redirect_to project_url(@project)
    end
  end
  
  
  
end
