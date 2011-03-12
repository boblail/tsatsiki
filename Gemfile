source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'sqlite3-ruby', :require => 'sqlite3'

gem 'gherkin', '2.3.2' # an API change post-2.3.2 breaks cucumber's GherkinFormatterAdapter
gem 'cucumber'
gem 'websocket-rack'

# We need to use a web server running EventMachine for WebSocket-Rack
# gem 'eventmachine', '>= 1.0.0'
gem 'thin'

# We'd be hypocrites if we didn't use cucumber for integration testing :)
group :development, :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
end

# I prefer to use mongrel to run the dev server
# group :development do
#   gem 'mongrel'
# end
