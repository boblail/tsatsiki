require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

class Hash
  def recursive_symbolize_keys!
    symbolize_keys!
    # symbolize each hash in .values
    values.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    # symbolize each hash inside an array in .values
    values.select{|v| v.is_a?(Array) }.flatten.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    self
  end
end

module Tsatsiki
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Please note that JavaScript expansions are *ignored altogether* if the asset
    # pipeline is enabled (see config.assets.enabled below). Put your defaults in
    # app/assets/javascripts/application.js in that case.
    #
    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(prototype prototype_ujs)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true
    
    # Configure email
    unless Rails.env.test?
      email_yml = "#{Rails.root.to_s}/config/email.yml"
      unless File.exists?(email_yml)
        puts "====================================================================",
             "Tsatsiki doesn't know how to send email on your server.",
             "Please copy email.yml.example to email.yml and edit the",
             "file so that it contains the appropriate settings. ",
             "===================================================================="
      else
        require 'tlsmail'
        Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
        email_settings = YAML::load(File.open(email_yml)).recursive_symbolize_keys!
        email_settings = email_settings[Rails.env.to_sym] || {}
        email_settings.each do |key, value|
          config.action_mailer[key] = value
        end
      end
    end
  end
end
