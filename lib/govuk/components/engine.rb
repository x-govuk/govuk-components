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

    # @!group Defaults
    #
    # Default components configuration
    #
    # +:default_back_link_text+ Default text for the back link, defaults to +Back+
    # +:default_breadcrumbs_collapse_on_mobile+ false
    # +:default_breadcrumbs_hide_in_print+ false
    # +:default_cookie_banner_aria_label+ "Cookie banner"
    # +:default_cookie_banner_hide_in_print+ true
    # +:default_header_navigation_label+ 'Navigation menu'
    # +:default_header_menu_button_label+ 'Show or hide navigation menu'
    # +:default_header_logotype+ 'GOV.UK'
    # +:default_header_homepage_url+ '/'
    # +:default_header_service_name+ nil
    # +:default_header_service_url+ '/'
    # +:default_footer_meta_text+ nil
    # +:default_footer_copyright_text+ '© Crown copyright'
    # +:default_footer_copyright_url+ "https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/"
    # +:default_pagination_landmark_label+ "results"
    # +:default_pagination_next_text+ Default 'next' text for pagination. An +Array+ where the first item is visible and the second visually hidden. Defaults to ["Next", "page"]
    # +:default_pagination_previous_text+ Default 'previous' text for pagination. An +Array+ where the first item is visible and the second visually hidden. Defaults to ["Previous", "page"]
    # +:default_phase_banner_tag+ nil
    # +:default_phase_banner_text+ nil
    # +:default_section_break_visible+ false
    # +:default_section_break_size+ Size of the section break, possible values: +m+, +l+ and +xl+. Defaults to nil.
    # +:default_tag_colour+ the default colour for tags, possible values: +grey+, +green+, +turquoise+, +blue+, +red+, +purple+, +pink+, +orange+, +yellow+. Defaults to +nil+
    # +:default_start_button_as_button+ false
    # +:default_summary_list_borders+ true
    # +:default_notification_banner_title_id+ "govuk-notification-banner-title"
    # +:default_notification_disable_auto_focus+ nil
    # +:default_notification_title_heading_level+ 2
    # +:default_notification_title_success+ false
    # +:default_warning_text_icon_fallback_text+ "Warning"
    # +:default_warning_text_icon+ "!"
    #
    # +:require_summary_list_action_visually_hidden_text+ when true forces visually hidden text to be set for every action. It can still be explicitly skipped by passing in +nil+. Defaults to +false+
    # +:enable_auto_table_scopes+ automatically adds a scope of 'col' to th elements in thead and 'row' to th elements in tbody.
    DEFAULTS = {
      default_back_link_text: 'Back',
      default_breadcrumbs_collapse_on_mobile: false,
      default_breadcrumbs_hide_in_print: false,
      default_cookie_banner_aria_label: "Cookie banner",
      default_cookie_banner_hide_in_print: true,
      default_header_navigation_label: 'Navigation menu',
      default_header_menu_button_label: 'Show or hide navigation menu',
      default_header_logotype: 'GOV.UK',
      default_header_homepage_url: '/',
      default_header_service_name: nil,
      default_header_service_url: '/',
      default_footer_meta_text: nil,
      default_footer_copyright_text: '© Crown copyright',
      default_footer_copyright_url: "https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/",
      default_pagination_landmark_label: "results",
      default_pagination_next_text: %w(Next page),
      default_pagination_previous_text: %w(Previous page),
      default_phase_banner_tag: nil,
      default_phase_banner_text: nil,
      default_section_break_visible: false,
      default_section_break_size: nil,
      default_tag_colour: nil,
      default_start_button_as_button: false,
      default_summary_list_borders: true,
      default_notification_banner_title_id: "govuk-notification-banner-title",
      default_notification_disable_auto_focus: nil,
      default_notification_title_heading_level: 2,
      default_notification_title_success: false,
      default_warning_text_icon_fallback_text: "Warning",
      default_warning_text_icon: "!",

      default_link_new_tab_text: "(opens in new tab)",

      require_summary_list_action_visually_hidden_text: false,
      summary_list_action_visually_hidden_space: false,
      enable_auto_table_scopes: true,
    }.freeze

    DEFAULTS.each_key { |k| config_accessor(k) { DEFAULTS[k] } }

    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

Dir[Govuk::Components::Engine.root.join("app", "helpers", "*.rb")].sort.each { |f| require f }
