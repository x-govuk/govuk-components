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
    # +:brand+ sets the value used to prefix all classes, used to allow the components to be branded for alternative (similar) design systems
    # +:brand_overrides+ sets the value used to prefix classes and slots for the component class.
    # +:default_back_link_text+ Default text for the back link, defaults to +Back+
    # +:default_breadcrumbs_collapse_on_mobile+ false
    # +:default_breadcrumbs_hide_in_print+ false
    # +:default_cookie_banner_aria_label+ "Cookie banner"
    # +:default_cookie_banner_hide_in_print+ true
    # +:default_error_prefix+ Text to use at the start of the page title tag when there is an error on the page. Default is 'Error: '
    # +:default_exit_this_page_redirect_url+ The URL that the exit this page component links to by default. Defaults to https://www.bbc.co.uk/weather
    # +:default_exit_this_page_text+ The default text that forms the link. Defaults to 'Exit this page'
    # +:default_exit_this_page_activated_text+ Text announced by screen readers when Exit this Page has been activated via the keyboard shortcut. Default in govuk-frontend is 'Exiting page.' Defaults to nil so govuk-frontend value is used unless overridden.
    # +:default_exit_this_page_timed_out_text+ Text announced by screen readers when the keyboard shortcut has timed out without successful activation. Default in govuk-frontend is 'Exit this page expired.' Defaults to nil so govuk-frontend value is used unless overridden.
    # +:default_exit_this_page_press_two_more_times_text+ Text announced by screen readers when the user must press *Shift* two more times to activate the button. Default in govuk-frontend is 'Shift, press 2 more times to exit.' Defaults to nil so govuk-frontend value is used unless overridden.
    # +:default_exit_this_page_press_one_more_time_text+ Text announced by screen readers when the user must press *Shift* one more time to activate the button. Default in govuk-frontend is 'Shift, press 1 more time to exit.' Defaults to nil so govuk-frontend value is used unless overridden.
    # +:default_header_navigation_label+ 'Navigation menu'
    # +:default_header_menu_button_label+ 'Show or hide navigation menu'
    # +:default_header_homepage_url+ '/'
    # +:default_header_service_name+ nil
    # +:default_header_service_url+ '/'
    # +:default_footer_meta_text+ nil
    # +:default_footer_copyright_text+ '© Crown copyright'
    # +:default_footer_copyright_url+ "https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/"
    # +:default_pagination_landmark_label+ "Pagination"
    # +:default_pagination_next_text+ Default 'next' text for pagination. An +Array+ where the first item is visible and the second visually hidden. Defaults to ["Next", "page"]
    # +:default_pagination_previous_text+ Default 'previous' text for pagination. An +Array+ where the first item is visible and the second visually hidden. Defaults to ["Previous", "page"]
    # +:default_phase_banner_tag+ nil
    # +:default_phase_banner_text+ nil
    # +:default_section_break_visible+ false
    # +:default_section_break_size+ Size of the section break, possible values: +m+, +l+ and +xl+. Defaults to nil.
    # +:default_tag_colour+ the default colour for tags, possible values: +grey+, +green+, +turquoise+, +blue+, +red+, +purple+, +pink+, +orange+, +yellow+. Defaults to +nil+
    # +:default_start_button_as_button+ false
    # +:default_summary_list_borders+ true
    # +:default_summary_list_value_text+ the fallback text for summary list values which will be displayed when the value is nil. Defaults to +""+
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
      brand: 'govuk',
      brand_overrides: {
        # 'GovukComponent::AccordionComponent'           => 'another-brand',
        # 'GovukComponent::BackLinkComponent'            => 'another-brand',
        # 'GovukComponent::BreadcrumbsComponent'         => 'another-brand',
        # 'GovukComponent::CookieBannerComponent'        => 'another-brand',
        # 'GovukComponent::DetailsComponent'             => 'another-brand',
        # 'GovukComponent::ExitThisPageComponent'        => 'another-brand',
        # 'GovukComponent::FooterComponent'              => 'another-brand',
        # 'GovukComponent::HeaderComponent'              => 'another-brand',
        # 'GovukComponent::InsetTextComponent'           => 'another-brand',
        # 'GovukComponent::NotificationBannerComponent'  => 'another-brand',
        # 'GovukComponent::PaginationComponent'          => 'another-brand',
        # 'GovukComponent::PanelComponent'               => 'another-brand',
        # 'GovukComponent::PhaseBannerComponent'         => 'another-brand',
        # 'GovukComponent::SectionBreakComponent'        => 'another-brand',
        # 'GovukComponent::StartButtonComponent'         => 'another-brand',
        # 'GovukComponent::SummaryListComponent'         => 'another-brand',
        # 'GovukComponent::TableComponent'               => 'another-brand',
        # 'GovukComponent::TabComponent'                 => 'another-brand',
        # 'GovukComponent::TagComponent'                 => 'another-brand',
        # 'GovukComponent::TaskListComponent'            => 'another-brand',
        # 'GovukComponent::WarningTextComponent'         => 'another-brand',
      },
      default_back_link_text: 'Back',
      default_breadcrumbs_collapse_on_mobile: false,
      default_breadcrumbs_hide_in_print: false,
      default_cookie_banner_aria_label: "Cookie banner",
      default_cookie_banner_hide_in_print: true,
      default_error_prefix: "Error: ",
      default_exit_this_page_redirect_url: "https://www.bbc.co.uk/weather",
      default_exit_this_page_text: "Exit this page",
      default_exit_this_page_activated_text: nil,
      default_exit_this_page_timed_out_text: nil,
      default_exit_this_page_press_two_more_times_text: nil,
      default_exit_this_page_press_one_more_time_text: nil,
      default_header_navigation_label: 'Menu',
      default_header_menu_button_label: 'Show or hide menu',
      default_header_homepage_url: '/',
      default_header_service_name: nil,
      default_header_service_url: '/',
      default_footer_meta_text: nil,
      default_footer_copyright_text: '© Crown copyright',
      default_footer_copyright_url: "https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/",
      default_pagination_landmark_label: "Pagination",
      default_pagination_next_text: %w(Next page),
      default_pagination_previous_text: %w(Previous page),
      default_phase_banner_tag: nil,
      default_phase_banner_text: nil,
      default_section_break_visible: false,
      default_section_break_size: nil,
      default_tag_colour: nil,
      default_start_button_as_button: false,
      default_summary_list_borders: true,
      default_summary_list_value_text: "",
      default_notification_banner_title_id: "govuk-notification-banner-title",
      default_notification_disable_auto_focus: nil,
      default_notification_title_heading_level: 2,
      default_notification_title_success: false,
      default_warning_text_icon_fallback_text: "Warning",
      default_warning_text_icon: "!",
      default_link_new_tab_text: "(opens in new tab)",
      require_summary_list_action_visually_hidden_text: false,
      enable_auto_table_scopes: true,
    }.freeze

    DEFAULTS.each_key { |k| config_accessor(k) { DEFAULTS[k] } }

    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

Dir[Govuk::Components::Engine.root.join("app", "helpers", "*.rb")].sort.each { |f| require f }
