require_relative "boot"
# config/application.rb
require_relative "boot"

require "logger"   # <-- add this line for Ruby 3.3
require "rails/all"

Bundler.require(*Rails.groups)

module EmailEncouragements
  class Application < Rails::Application
    config.load_defaults 7.0
  end
end

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SupportEng
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
