class ScenariosController < ApplicationController
  
  
  
  def show
    @project           = Project.find(params[:project_id])
    feature            = @project.find_feature(params[:feature])
    line               = params[:line].to_i
    @selected_scenario = feature.scenarios.find {|scenario| scenario.line == line}
    render :layout => (request.xhr? ? false : "project")
  end
  
  
  
end
