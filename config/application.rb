require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KbprWeb
  class Application < Rails::Application
    config.i18n.default_locale = :hu
    config.i18n.fallbacks = [:en]
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.view_component.preview_controller = "MyPreviewController"
    config.view_component.default_preview_layout = "application"
  end
end
