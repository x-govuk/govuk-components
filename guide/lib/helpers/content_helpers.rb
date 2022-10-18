module Helpers
  module ContentHelpers
    def component_helper_mapping_table
      head = ["Component class name", "Helper method"]
      rows = component_helper_mapping.to_a.map { |v| v.map { |c| "<code>#{c}</code>".html_safe } }

      DsfrComponent::TableComponent.new(
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
        "DsfrComponent::AccordionComponent" => "dsfr_accordion",
        "DsfrComponent::BackLinkComponent" => "dsfr_back_link",
        "DsfrComponent::BreadcrumbsComponent" => "dsfr_breadcrumbs",
        "DsfrComponent::CookieBannerComponent" => "dsfr_cookie_banner",
        "DsfrComponent::DetailsComponent" => "dsfr_details",
        "DsfrComponent::FooterComponent" => "dsfr_footer",
        "DsfrComponent::HeaderComponent" => "dsfr_header",
        "DsfrComponent::InsetTextComponent" => "dsfr_inset_text",
        "DsfrComponent::NotificationBannerComponent" => "dsfr_notification_banner",
        "DsfrComponent::PaginationComponent" => "dsfr_pagination",
        "DsfrComponent::PanelComponent" => "dsfr_panel",
        "DsfrComponent::PhaseBannerComponent" => "dsfr_phase_banner",
        "DsfrComponent::StartButtonComponent" => "dsfr_start_button",
        "DsfrComponent::SummaryListComponent" => "dsfr_summary_list",
        "DsfrComponent::TableComponent" => "dsfr_table",
        "DsfrComponent::TabComponent" => "dsfr_tabs",
        "DsfrComponent::TagComponent" => "dsfr_tag",
        "DsfrComponent::WarningTextComponent" => "dsfr_warning_text",
      }
    end
  end
end
