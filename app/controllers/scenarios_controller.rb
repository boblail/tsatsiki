class ScenariosController < ApplicationController
  before_filter :find_scenario
  include UrlHelper
  
  
  
  def show
    render :layout => (request.xhr? ? false : "project")
  end
  
  
  
  def edit
    render :layout => (request.xhr? ? false : "project")
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
  
  
  
private
  
  
  
  def find_scenario
    @project           = Project.find(params[:project_id])
    @feature           = @project.find_feature(params[:feature])
    index              = params[:index].to_i - 1
    @selected_scenario = @feature.scenarios[index]
  end
  
  
  
end
