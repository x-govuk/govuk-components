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

  private

    def component_helper_mapping
      {
        "GovukComponent::Accordion" => "govuk_accordion",
        "GovukComponent::BackLink" => "govuk_back_link",
        "GovukComponent::Breadcrumbs" => "govuk_breadcrumbs",
        "GovukComponent::CookieBanner" => "govuk_cookie_banner",
        "GovukComponent::Details" => "govuk_details",
        "GovukComponent::Footer" => "govuk_footer",
        "GovukComponent::Header" => "govuk_header",
        "GovukComponent::InsetText" => "govuk_inset_text",
        "GovukComponent::NotificationBanner" => "govuk_notification_banner",
        "GovukComponent::Panel" => "/components/panel",
        "GovukComponent::PhaseBanner" => "govuk_phase_banner",
        "GovukComponent::StartButton" => "govuk_start_button",
        "GovukComponent::SummaryList" => "govuk_summary_list",
        "GovukComponent::Table" => "govuk_table",
        "GovukComponent::Tabs" => "govuk_tabs",
        "GovukComponent::Tag" => "govuk_tag",
        "GovukComponent::WarningText" => "govuk_warning_text",
      }
    end
  end
end
