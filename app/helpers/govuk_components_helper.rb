module GovukComponentsHelper
  {
    govuk_accordion: 'GovukComponent::AccordionComponent',
    govuk_back_link: 'GovukComponent::BackLinkComponent',
    govuk_breadcrumbs: 'GovukComponent::BreadcrumbsComponent',
    govuk_cookie_banner: 'GovukComponent::CookieBanner',
    govuk_details: 'GovukComponent::Details',
    govuk_footer: 'GovukComponent::Footer',
    govuk_header: 'GovukComponent::Header',
    govuk_inset_text: 'GovukComponent::InsetText',
    govuk_notification_banner: 'GovukComponent::NotificationBanner',
    govuk_panel: 'GovukComponent::PanelComponent',
    govuk_phase_banner: 'GovukComponent::PhaseBanner',
    govuk_start_now_button: 'GovukComponent::StartNowButton',
    govuk_summary_list: 'GovukComponent::SummaryList',
    govuk_tabs: 'GovukComponent::TabComponent',
    govuk_tag: 'GovukComponent::TagComponent',
    govuk_warning_text: 'GovukComponent::WarningTextComponent',
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

ActiveSupport.on_load(:action_view) { include GovukComponentsHelper }
