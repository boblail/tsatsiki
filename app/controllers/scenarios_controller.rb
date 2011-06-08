class ScenariosController < ApplicationController
  
  
  
  def show
    project   = Project.find(params[:project_id])
    feature   = project.find_feature(params[:feature])
    line      = params[:line].to_i
    @scenario = feature.scenarios.find {|scenario| scenario.line == line}
    # respond_with(@scenario)
    render :layout => false
  end
  
  
  
end
