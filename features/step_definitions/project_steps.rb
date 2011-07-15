


Given /^there is a project "([^"]*)"$/ do |name|
  @project = Project.find_by_name(name) || Project.create!(:name => name, :path => Rails.root.to_s, :user => User.find_by_username('admin'))
end

Given /^the following projects:$/ do |projects|
  Project.create!(projects.hashes)
end



When /^I delete the (\d+)(?:st|nd|rd|th) project$/ do |pos|
  visit projects_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end



Then /^I should see the following projects:$/ do |expected_projects_table|
  expected_projects_table.diff!(tableish('table tr', 'td,th'))
end

Then /^I should see the Tsatsiki features$/ do
  # Slime
end

Then /^the "([^"]*)" feature should be in the category "([^"]*)"$/ do |feature, category_path|
  within("li[data-path=\"features#{category_path}.feature\"]") do
    assert page.has_content?(feature)
  end
end

