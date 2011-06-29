

Given /^this feature has a table:$/ do |table|
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
