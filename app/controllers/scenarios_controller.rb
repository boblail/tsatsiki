class ScenariosController < ApplicationController
  before_filter :find_scenario
  
  
  
  def show
    render :layout => (request.xhr? ? false : "project")
  end
  
  
  
  def edit
    render :layout => (request.xhr? ? false : "project")
  end
  
  
  
  def update
    @selected_scenario.name = params[:name]
    @feature.write!
    head :ok
  end
  
  
  
private
  
  
  
  def find_scenario
    @project           = Project.find(params[:project_id])
    @feature           = @project.find_feature(params[:feature])
    index              = params[:index].to_i - 1
    @selected_scenario = @feature.scenarios[index]
  end
  
  
  
end
