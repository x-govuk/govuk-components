module DsfrComponentsHelper
  {
    dsfr_accordion: 'DsfrComponent::AccordionComponent',
    dsfr_back_link: 'DsfrComponent::BackLinkComponent',
    dsfr_breadcrumbs: 'DsfrComponent::BreadcrumbsComponent',
    dsfr_cookie_banner: 'DsfrComponent::CookieBannerComponent',
    dsfr_details: 'DsfrComponent::DetailsComponent',
    dsfr_footer: 'DsfrComponent::FooterComponent',
    dsfr_header: 'DsfrComponent::HeaderComponent',
    dsfr_inset_text: 'DsfrComponent::InsetTextComponent',
    dsfr_notification_banner: 'DsfrComponent::NotificationBannerComponent',
    dsfr_pagination: 'DsfrComponent::PaginationComponent',
    dsfr_panel: 'DsfrComponent::PanelComponent',
    dsfr_phase_banner: 'DsfrComponent::PhaseBannerComponent',
    dsfr_section_break: 'DsfrComponent::SectionBreakComponent',
    dsfr_start_button: 'DsfrComponent::StartButtonComponent',
    dsfr_summary_list: 'DsfrComponent::SummaryListComponent',
    dsfr_table: 'DsfrComponent::TableComponent',
    dsfr_tabs: 'DsfrComponent::TabComponent',
    dsfr_tag: 'DsfrComponent::TagComponent',
    dsfr_warning_text: 'DsfrComponent::WarningTextComponent',
  }.each do |name, klass|
    define_method(name) do |*args, **kwargs, &block|
      capture do
        render(klass.constantize.new(*args, **kwargs)) do |com|
          block.call(com) if block.present?
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_view) { include DsfrComponentsHelper }
