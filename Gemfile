source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'sqlite3-ruby', :require => 'sqlite3'

# gem 'gherkin', '2.3.2' # an API change post-2.3.2 breaks cucumber's GherkinFormatterAdapter
gem 'cucumber'
gem 'websocket-rack', '0.3.0'
gem 'childprocess'
gem 'tsatsiki-cucumber-formatter'

# We need to use a web server running EventMachine for WebSocket-Rack
gem 'thin'

# We'd be hypocrites if we didn't use cucumber for integration testing :)
group :development, :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
end
