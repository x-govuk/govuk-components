require 'spec_helper'

class HelperComponentMapping
  attr_reader :helper_method, :klass, :args, :kwargs, :css_matcher, :block

  def initialize(helper_method:, klass:, args:, kwargs:, css_matcher:, block: nil)
    @helper_method = helper_method
    @klass         = klass
    @args          = args
    @kwargs        = kwargs
    @css_matcher   = css_matcher
    @block         = block
  end
end

RSpec.describe(DsfrComponentsHelper, type: 'helper') do
  include_context 'helpers'

  [
    {
      helper_method: :dsfr_accordion,
      klass: DsfrComponent::AccordionComponent,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-accordion)
    },
    {
      helper_method: :dsfr_back_link,
      klass: DsfrComponent::BackLinkComponent,
      args: [],
      kwargs: { text: 'Back', href: '/right-to-the-start' },
      css_matcher: %(.govuk-back-link)
    },
    {
      helper_method: :dsfr_breadcrumbs,
      klass: DsfrComponent::BreadcrumbsComponent,
      args: [],
      kwargs: { breadcrumbs: { one: 'One' } },
      css_matcher: %(.govuk-breadcrumbs)
    },
    {
      helper_method: :dsfr_details,
      klass: DsfrComponent::DetailsComponent,
      args: [],
      kwargs: { summary_text: 'Summary' },
      css_matcher: %(.govuk-details)
    },
    {
      helper_method: :dsfr_footer,
      klass: DsfrComponent::FooterComponent,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-footer)
    },
    {
      helper_method: :dsfr_header,
      klass: DsfrComponent::HeaderComponent,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-header)
    },
    {
      helper_method: :dsfr_inset_text,
      klass: DsfrComponent::InsetTextComponent,
      args: [],
      kwargs: { text: 'Inset text' },
      css_matcher: %(.govuk-inset-text)
    },
    {
      helper_method: :dsfr_cookie_banner,
      klass: DsfrComponent::CookieBannerComponent,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-cookie-banner)
    },
    {
      helper_method: :dsfr_notification_banner,
      klass: DsfrComponent::NotificationBannerComponent,
      args: [],
      kwargs: { title_text: 'Notification banner' },
      css_matcher: %(.govuk-notification-banner),
      block: Proc.new { |nb| nb.heading(text: "heading 1", link_text: "link 1", link_href: "/link-1") },
    },
    {
      helper_method: :dsfr_panel,
      klass: DsfrComponent::PanelComponent,
      args: [],
      kwargs: { title_text: 'Panel title', text: 'Panel body' },
      css_matcher: %(.govuk-panel)
    },
    {
      helper_method: :dsfr_phase_banner,
      klass: DsfrComponent::PhaseBannerComponent,
      args: [],
      kwargs: { tag: { text: 'Phase Test' } },
      css_matcher: %(.govuk-phase-banner)
    },
    {
      helper_method: :dsfr_section_break,
      klass: DsfrComponent::SectionBreakComponent,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-section-break)
    },
    {
      helper_method: :dsfr_start_button,
      klass: DsfrComponent::StartButtonComponent,
      args: [],
      kwargs: { text: 'Start now text', href: '/start-now-href' },
      css_matcher: %(.fr-btn)
    },
    {
      helper_method: :dsfr_summary_list,
      klass: DsfrComponent::SummaryListComponent,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-summary-list)
    },
    {
      helper_method: :dsfr_table,
      klass: DsfrComponent::TableComponent,
      args: [],
      kwargs: { caption: 'Table', rows: [%w(a b c), %w(d e f)] },
      css_matcher: %(.govuk-table)
    },
    {
      helper_method: :dsfr_tabs,
      klass: DsfrComponent::TabComponent,
      args: [],
      kwargs: { title: 'Tabs' },
      css_matcher: %(.govuk-tabs)
    },
    {
      helper_method: :dsfr_tag,
      klass: DsfrComponent::TagComponent,
      args: [],
      kwargs: { text: 'Tag' },
      css_matcher: %(.govuk-tag)
    },
    {
      helper_method: :dsfr_warning_text,
      klass: DsfrComponent::WarningTextComponent,
      args: [],
      kwargs: { text: 'Warning' },
      css_matcher: %(.govuk-warning-text)
    },
  ]
    .map { |h| HelperComponentMapping.new(**h) }
    .each do |hcm|
      describe hcm.helper_method do
        subject do
          helper.send(hcm.helper_method, *hcm.args, **hcm.kwargs, &hcm.block)
        end

        specify %(should render the component #{hcm.klass}) do
          expect(subject).to have_tag(hcm.css_matcher)
        end
      end
    end
end
