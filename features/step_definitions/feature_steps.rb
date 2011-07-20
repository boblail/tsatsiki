

Given /^a table:$/ do |table|
  # Don't do anything: we're just testing parsing and rendering
end

Given /^a multiline string:$/ do |string|
  # Don't do anything: we're just testing parsing and rendering
end

Given /^a placeholder for an .*$/ do
  # Don't do anything: we're just testing parsing and rendering
end

When /^I load the feature "([^"]*)"$/ do |path|
  tsatsiki = Project.find_by_name "Tsatsiki"
  @feature = tsatsiki.find_feature "features/#{path}"
  assert @feature, "A feature with the path \"#{path}\" was not found"
end

When /^I render the feature$/ do
  @rendered_feature = @feature.render
end

Then /^the result should be identical to "([^"]*)"$/ do |path|
  this_file = Rails.root.join("features", path)
  contents = File.read(this_file)
  assert_equal contents, @rendered_feature
end



Given /^this feature is "([^"]*)"$/ do |path|
  @this_feature_path = Rails.root.join("features", path).to_s
  @original_content = File.exists?(@this_feature_path) ? File.read(@this_feature_path) : nil
end

Then /^this feature should contain a scenario "([^"]*)"$/ do |scenario_name|
  expectation = /Scenario: #{scenario_name}$/
  contents = File.read(@this_feature_path)
  assert_match expectation, contents
end

Then /^this feature should not contain a scenario "([^"]*)"$/ do |scenario_name|
  expectation = /Scenario: #{scenario_name}$/
  contents = File.read(@this_feature_path)
  assert_no_match expectation, contents
end



Then /^this feature (?:should )?exists?$/ do
  assert File.exists?(@this_feature_path)
end

Then /^this feature (?:does|should) not exist$/ do
  assert !File.exists?(@this_feature_path)
end



Given /^revert this feature$/ do
  if @original_content.nil?
    FileUtils.rm(@this_feature_path)
  else
    File.open(@this_feature_path, 'w') {|f| f.write(@original_content) }
  end
end



Then /^this feature should not be executed$/ do
  flunk "This step should not be executed"
end
