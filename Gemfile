source 'http://rubygems.org'

gem 'rails', '3.1.0'

# DB
gem 'sqlite3'
gem 'mysql2'

# JS
gem 'jquery-rails'
gem 'underscore-rails'

# Right now Rails seems to still require this:
gem 'therubyracer'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

# Authentication and Authorization
gem 'devise'
gem 'devise_invitable'
gem 'cancan'

# Required in order to send mail via Gmail.
gem 'tlsmail'

# For parsing and everything
gem 'cucumber'

# Run cucumber in the background and stream results to the web page
gem 'daemons'
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
  
  # Pretty printed test output
  gem 'turn', :require => false
end
