


Then /^I should see the (alert|notice|error)(?: message)? "([^"]*)"$/ do |kind, message|
  # within("#flash_#{kind}") do
    assert page.has_content?(message)
  # end
end

Then /^I should not see the (alert|notice|error)(?: message)? "([^"]*)"$/ do |kind, message|
  assert !page.has_content?(message)
end
