require_relative 'boot'

require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)
require "govuk/components"

module Sprockets
  module Rails
    def self.deprecator
      @deprecator ||= ActiveSupport::Deprecation.new("4.0", "Sprockets::Rails")
    end
  end
end

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.view_component.default_preview_layout = "preview"
  end
end
