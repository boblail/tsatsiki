module NavigationHelpers
  include UrlHelper
  
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      
    when /the home\s?page/
      '/'
      
    when /the new project page/
      new_project_path
      
    when /the (.*) project page/i
      project_path(Project.find_by_name($1))
      
    when /the project's page/i
      project_path(@project)
      
    when /the project's settings page/i
      edit_project_path(@project)
      
    when /the page for one of the project's scenarios/i
      scenario = @project.scenarios.first
      scenario_path(scenario)
      
    when /the edit page for one of the project's scenarios/i
      scenario = @project.scenarios.first
      edit_scenario_path(scenario)
      
    when /the new scenario page for one of the project's features/i
      feature = @project.features.first
      new_scenario_path(feature)
      
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
