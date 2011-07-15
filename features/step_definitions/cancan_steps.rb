

Given /^I have "([^"]*)" privileges for (.*?)$/ do |privilege, subject|
  subject = case subject
  when "the project";                   :project
  when "the project's features";        :features
  else;                                 pending("cancan_steps.rb does not handle the subject \"#{subject}\"")
  end
  
  authorization = AuthorizedProject.find_or_create_by_user_id_and_project_id(@user.id, @project.id)
  authorization.privileges[subject] = privilege
  authorization.save!
end
