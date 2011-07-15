


Given /^I am logged in$/ do
  Given %Q{there is a user "user"}
  login_as @user
end

Given /^I am logged in as an admin$/ do
  Given %Q{there is a user "admin" who is an admin}
  login_as @user
end



Given /^there is a user "([^"]*)"( who is an admin)?$/ do |username, who_is_an_admin|
  @user = User.find_by_username(username) || User.new({
    :username => username,
    :password => "password",
    :password_confirmation => "password",
    :email => "#{username}@example.com"
  })
  @user.admin = !who_is_an_admin.blank?
  @user.save!
end