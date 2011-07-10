source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# Asset template engines
gem 'json'
gem 'sass'
gem 'coffee-script'
gem 'therubyracer', '0.8.1'
gem 'uglifier'

gem 'mongrel'

gem 'jquery-rails'

gem 'devise'
gem 'devise_invitable'
gem 'cancan'

gem 'tlsmail' # Required in order to send mail via Gmail.

gem 'cucumber'
gem 'websocket-rack', '0.3.0'
gem 'childprocess'
gem 'tsatsiki-cucumber-formatter', :git => 'git://github.com/boblail/tsatsiki-cucumber-formatter.git'

# We need to use a web server running EventMachine for Websocket-Rack
gem 'thin'

group :development do
  gem "ruby-debug", :platforms => :mri_18
  gem "ruby-debug19", :platforms => :mri_19
end

# We'd be hypocrites if we didn't use cucumber for integration testing :)
group :development, :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
end
