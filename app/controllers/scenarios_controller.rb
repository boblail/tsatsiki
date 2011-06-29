class ScenariosController < ApplicationController
  before_filter :find_scenario
  
  
  
  def show
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
    line               = params[:line].to_i
    @selected_scenario = @feature.scenarios.find {|scenario| scenario.line == line}
  end
  
  
  
end
