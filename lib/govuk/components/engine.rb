require "rails/engine"
require "active_support/configurable"

module Govuk
  module Components
    include ActiveSupport::Configurable

    class << self
      # Configure the form builder in the usual manner. All of the
      # keys in {DEFAULTS} can be configured as per the example below
      #
      # @example
      #   Govuk::Components.configure do |conf|
      #     conf.do_some_things = 'yes'
      #   end
      def configure
        yield(config)
      end

      # Resets each of the configurable values to its default
      #
      # @note This method is only really intended for use to clean up
      #   during testing
      def reset!
        configure do |c|
          DEFAULTS.each { |k, v| c.send("#{k}=", v) }
        end
      end
    end

    DEFAULTS = {
      hello: "world"
    }.freeze

    DEFAULTS.each_key { |k| config_accessor(k) { DEFAULTS[k] } }

    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

Dir[Govuk::Components::Engine.root.join("app", "helpers", "*.rb")].sort.each { |f| require f }
