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
      default_back_link_component_text: 'Back',
      default_breadcrumbs_component_collapse_on_mobile: false,
      default_breadcrumbs_component_hide_in_print: false,
      default_cookie_banner_aria_label: "Cookie banner",
      default_cookie_banner_hide_in_print: true,
      default_header_component_navigation_label: 'Navigation menu',
      default_header_component_menu_button_label: 'Show or hide navigation menu',
      default_header_component_logotype: 'GOV.UK',
      default_header_component_homepage_url: '/',
      default_header_component_service_name: nil,
      default_header_component_service_url: '/',
      default_footer_component_meta_text: nil,
      default_footer_component_copyright_text: '© Crown copyright',
      default_footer_component_copyright_url: "https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/",
      default_pagination_landmark_label: "results",
      default_pagination_next_text: %w(Next page),
      default_pagination_previous_text: %w(Previous page),
      default_phase_banner_component_tag: nil,
      default_phase_banner_component_text: nil,
      default_section_break_visible: false,
      default_section_break_size: nil,
      default_tag_component_colour: nil,
    }.freeze

    DEFAULTS.each_key { |k| config_accessor(k) { DEFAULTS[k] } }

    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

Dir[Govuk::Components::Engine.root.join("app", "helpers", "*.rb")].sort.each { |f| require f }
