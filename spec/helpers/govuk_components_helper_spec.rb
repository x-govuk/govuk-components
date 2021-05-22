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

RSpec.describe(GovukComponentsHelper, type: 'helper', version: 1) do
  include_context 'helpers'

  [
    {
      helper_method: :govuk_accordion,
      klass: GovukComponent::Accordion,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-accordion)
    },
    {
      helper_method: :govuk_back_link,
      klass: GovukComponent::BackLink,
      args: [],
      kwargs: { text: 'Back', href: '/right-to-the-start' },
      css_matcher: %(.govuk-back-link)
    },
    {
      helper_method: :govuk_breadcrumbs,
      klass: GovukComponent::Breadcrumbs,
      args: [],
      kwargs: { breadcrumbs: { one: 'One' } },
      css_matcher: %(.govuk-breadcrumbs)
    },
    {
      helper_method: :govuk_details,
      klass: GovukComponent::Details,
      args: [],
      kwargs: { summary: 'Summary' },
      css_matcher: %(.govuk-details)
    },
    {
      helper_method: :govuk_footer,
      klass: GovukComponent::Footer,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-footer)
    },
    {
      helper_method: :govuk_header,
      klass: GovukComponent::Header,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-header)
    },
    {
      helper_method: :govuk_inset_text,
      klass: GovukComponent::InsetText,
      args: [],
      kwargs: { text: 'Inset text' },
      css_matcher: %(.govuk-inset-text)
    },
    {
      helper_method: :govuk_cookie_banner,
      klass: GovukComponent::CookieBanner,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-cookie-banner)
    },
    {
      helper_method: :govuk_notification_banner,
      klass: GovukComponent::NotificationBanner,
      args: [],
      kwargs: { title: 'Notification banner' },
      css_matcher: %(.govuk-notification-banner),
      block: Proc.new { |nb| nb.add_heading(text: "heading 1", link_text: "link 1", link_target: "/link-1") },
    },
    {
      helper_method: :govuk_panel,
      klass: GovukComponent::Panel,
      args: [],
      kwargs: { title: 'Panel title', body: 'Panel body' },
      css_matcher: %(.govuk-panel)
    },
    {
      helper_method: :govuk_phase_banner,
      klass: GovukComponent::PhaseBanner,
      args: [],
      kwargs: { phase_tag: { text: 'Phase Test' } },
      css_matcher: %(.govuk-phase-banner)
    },
    {
      helper_method: :govuk_start_now_button,
      klass: GovukComponent::StartNowButton,
      args: [],
      kwargs: { text: 'Start now text', href: '/start-now-href' },
      css_matcher: %(.govuk-button)
    },
    {
      helper_method: :govuk_summary_list,
      klass: GovukComponent::SummaryList,
      args: [],
      kwargs: {},
      css_matcher: %(.govuk-summary-list)
    },
    {
      helper_method: :govuk_tabs,
      klass: GovukComponent::TabComponent,
      args: [],
      kwargs: { title: 'Tabs' },
      css_matcher: %(.govuk-tabs)
    },
    {
      helper_method: :govuk_tag,
      klass: GovukComponent::TagComponent,
      args: [],
      kwargs: { text: 'Tag' },
      css_matcher: %(.govuk-tag)
    },
    {
      helper_method: :govuk_warning,
      klass: GovukComponent::Warning,
      args: [],
      kwargs: { text: 'Warning' },
      css_matcher: %(.govuk-warning-text)
    },
  ]
    .map { |h| HelperComponentMapping.new(**h) }
    .each do |hcm|
      describe hcm.helper_method do
        subject do
          Capybara::Node::Simple.new(helper.send(hcm.helper_method, *hcm.args, **hcm.kwargs, &hcm.block))
        end
        specify %(should render the component #{hcm.klass}) do
          expect(subject).to have_css(hcm.css_matcher)
        end
      end
    end
end
