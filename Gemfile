source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'sprockets', '2.0.0.beta.10' # newer versions don't work with rails 3.1.0.rc4

# DB
gem 'sqlite3'

# JS
gem 'jquery-rails'

# Asset template engines
gem 'json'
gem 'sass'
gem 'coffee-script'
gem 'therubyracer', '0.8.1'
gem 'uglifier'

# Authentication and Authorization
gem 'devise'
gem 'devise_invitable'
gem 'cancan'

# Required in order to send mail via Gmail.
gem 'tlsmail'

# For parsing and everything
gem 'cucumber'

# Run cucumber in the background and stream results to the web page
gem 'eventmachine', '1.0.0.beta.3'
gem 'em-websocket'
gem 'childprocess'

group :development do
  gem "ruby-debug", :platforms => :mri_18
  gem "ruby-debug19", :platforms => :mri_19
  gem 'mongrel', '1.2.0.pre2', :platforms => :mri_19
end

# We'd be hypocrites if we didn't use cucumber for integration testing :)
group :development, :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end
