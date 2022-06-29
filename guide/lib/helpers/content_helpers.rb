module Helpers
  module ContentHelpers
    def component_helper_mapping_table
      head = ["Component class name", "Helper method"]
      rows = component_helper_mapping.to_a.map { |v| v.map { |c| "<code>#{c}</code>".html_safe } }

      GovukComponent::TableComponent.new(
        head: head,
        rows: rows,
        caption: "Component to helper mappings"
      )
    end

    def accordion_info
      {
        "GOV.UK Design System accordion documentation" => "https://design-system.service.gov.uk/components/accordion/"
      }
    end

    def back_link_info
      {
        "GOV.UK Design System back link documentation" => "https://design-system.service.gov.uk/components/back-link/"
      }
    end

    def breadcrumbs_info
      {
        "GOV.UK Design System breadcrumbs documentation" => "https://design-system.service.gov.uk/components/breadcrumbs/"
      }
    end

    def cookie_banner_info
      {
        "GOV.UK Design System cookie banner documentation" => "https://design-system.service.gov.uk/components/cookie-banner/"
      }
    end

    def details_info
      {
        "GOV.UK Design System details documentation" => "https://design-system.service.gov.uk/components/details/"
      }
    end

    def footer_info
      {
        "GOV.UK Design System footer documentation" => "https://design-system.service.gov.uk/components/footer/"
      }
    end

    def header_info
      {
        "GOV.UK Design System header documentation" => "https://design-system.service.gov.uk/components/header/"
      }
    end

    def notification_banner_info
      {
        "GOV.UK Design System notification banner documentation" => "https://design-system.service.gov.uk/components/notification-banner/"
      }
    end

    def panel_info
      {
        "GOV.UK Design System panel documentation" => "https://design-system.service.gov.uk/components/panel/"
      }
    end

    def section_break_info
      {
        "GOV.UK Design System section break documentation" => "https://design-system.service.gov.uk/styles/typography/#section-break"
      }
    end

    def start_button_info
      {
        "GOV.UK Design System start button documentation" => "https://design-system.service.gov.uk/components/button/#start-buttons"
      }
    end

    def summary_list_info
      {
        "GOV.UK Design System summary list documentation" => "https://design-system.service.gov.uk/components/summary-list/"
      }
    end

    def table_info
      {
        "GOV.UK Design System table documentation" => "https://design-system.service.gov.uk/components/table/"
      }
    end

    def tabs_info
      {
        "GOV.UK Design System tabs documentation" => "https://design-system.service.gov.uk/components/tabs/"
      }
    end

    def tag_info
      {
        "GOV.UK Design System tag documentation" => "https://design-system.service.gov.uk/components/tag/"
      }
    end

    def warning_text_info
      {
        "GOV.UK Design System warning text documentation" => "https://design-system.service.gov.uk/components/warning-text/"
      }
    end

  private

    def component_helper_mapping
      {
        "GovukComponent::AccordionComponent" => "govuk_accordion",
        "GovukComponent::BackLinkComponent" => "govuk_back_link",
        "GovukComponent::BreadcrumbsComponent" => "govuk_breadcrumbs",
        "GovukComponent::CookieBannerComponent" => "govuk_cookie_banner",
        "GovukComponent::DetailsComponent" => "govuk_details",
        "GovukComponent::FooterComponent" => "govuk_footer",
        "GovukComponent::HeaderComponent" => "govuk_header",
        "GovukComponent::InsetTextComponent" => "govuk_inset_text",
        "GovukComponent::NotificationBannerComponent" => "govuk_notification_banner",
        "GovukComponent::PaginationComponent" => "govuk_pagination",
        "GovukComponent::PanelComponent" => "govuk_panel",
        "GovukComponent::PhaseBannerComponent" => "govuk_phase_banner",
        "GovukComponent::StartButtonComponent" => "govuk_start_button",
        "GovukComponent::SummaryListComponent" => "govuk_summary_list",
        "GovukComponent::TableComponent" => "govuk_table",
        "GovukComponent::TabComponent" => "govuk_tabs",
        "GovukComponent::TagComponent" => "govuk_tag",
        "GovukComponent::WarningTextComponent" => "govuk_warning_text",
      }
    end
  end
end
