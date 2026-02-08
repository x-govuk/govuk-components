module GovukComponentsHelper
  {
    govuk_accordion: 'GovukComponent::AccordionComponent',
    govuk_back_link: 'GovukComponent::BackLinkComponent',
    govuk_breadcrumbs: 'GovukComponent::BreadcrumbsComponent',
    govuk_cookie_banner: 'GovukComponent::CookieBannerComponent',
    govuk_details: 'GovukComponent::DetailsComponent',
    govuk_exit_this_page: 'GovukComponent::ExitThisPageComponent',
    govuk_footer: 'GovukComponent::FooterComponent',
    govuk_header: 'GovukComponent::HeaderComponent',
    govuk_inset_text: 'GovukComponent::InsetTextComponent',
    govuk_notification_banner: 'GovukComponent::NotificationBannerComponent',
    govuk_pagination: 'GovukComponent::PaginationComponent',
    govuk_panel: 'GovukComponent::PanelComponent',
    govuk_phase_banner: 'GovukComponent::PhaseBannerComponent',
    govuk_service_navigation: 'GovukComponent::ServiceNavigationComponent',
    govuk_section_break: 'GovukComponent::SectionBreakComponent',
    govuk_start_button: 'GovukComponent::StartButtonComponent',
    govuk_summary_list: 'GovukComponent::SummaryListComponent',
    govuk_summary_card: 'GovukComponent::SummaryListComponent::CardComponent',
    govuk_table: 'GovukComponent::TableComponent',
    govuk_tabs: 'GovukComponent::TabComponent',
    govuk_tag: 'GovukComponent::TagComponent',
    govuk_task_list: 'GovukComponent::TaskListComponent',
    govuk_warning_text: 'GovukComponent::WarningTextComponent',
  }.each do |name, klass|
    define_method(name) do |*args, **kwargs, &block|
      capture do
        render(klass.constantize.new(*args, **kwargs)) do |com|
          block.call(com) if block_given?
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_view) { include GovukComponentsHelper }
