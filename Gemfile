source 'http://rubygems.org'

# Need this commit: https://github.com/carlhuda/bundler/commit/4faa8e4a24d4665d1a4eabb4c64e00c90b2cb827
# c.f. https://github.com/carlhuda/bundler/issues/900
# c.f. http://spectator.in/2011/01/28/bundler-in-subshells/
gem 'bundler', '>= 1.1.pre.5'

gem 'rails', '3.1.0.rc4'

# DB
gem 'sqlite3'

# Server
gem 'mongrel'

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

# The prerelease of Bundler fails to install rbx-require-relative
# on any version of Ruby < 1.9.2. Comment out these lines until fixed
#
# group :development do
#   gem "ruby-debug", :platforms => :mri_18
#   gem "ruby-debug19", :platforms => :mri_19
# end

# We'd be hypocrites if we didn't use cucumber for integration testing :)
group :development, :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end
