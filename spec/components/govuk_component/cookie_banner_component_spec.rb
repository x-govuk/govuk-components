require "spec_helper"

RSpec.describe(DsfrComponent::CookieBannerComponent, type: :component) do
  let(:component_css_class) { 'govuk-cookie-banner' }
  let(:kwargs) { {} }

  subject! do
    render_inline(described_class.new(**kwargs))
  end

  specify "renders a cookie banner div with the default attributes" do
    expected_attributes = {
      class: %w(govuk-cookie-banner govuk-\!-display-none-print),
      role: "region",
      "aria-label" => "Cookie banner",
      "data-nosnippet" => "true"
    }

    expect(rendered_content).to have_tag("div", with: expected_attributes)
  end

  context "when hide_in_print: false" do
    subject! { render_inline(described_class.new(**kwargs.merge(hide_in_print: false))) }

    specify "the cookie banner does not have the `govuk-!-display-none-print` class" do
      expect(rendered_content).to have_tag(
        "div",
        with: { class: component_css_class },
        without: { class: "govuk-\\!-display-none-print" }
      )
    end
  end

  context "when hidden: true" do
    subject! { render_inline(described_class.new(**kwargs.merge(hidden: true))) }

    specify "the cookie banner has a hidden attribute" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class, hidden: "hidden" })
    end
  end

  context "when the aria-label is overridden" do
    let(:custom_label) { "Privacy information" }
    subject! { render_inline(described_class.new(**kwargs.merge(aria_label: custom_label))) }

    specify "the cookie banner has the custom aria-label value" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class, "aria-label" => custom_label })
    end
  end

  context "with messages and actions" do
    let(:message_selector) do
      ".govuk-cookie-banner > .govuk-cookie-banner__message > .govuk-grid-row > .govuk-grid-column-two-thirds"
    end

    let(:custom_heading_text) { "What a nice heading" }
    let(:custom_message_text) { "A really important message" }
    let(:custom_role) { "alert" }

    subject! do
      render_inline(described_class.new(**kwargs)) do |cookie_banner|
        cookie_banner.message(heading_text: custom_heading_text, role: custom_role, text: custom_message_text) do |message|
          message.action { helper.dsfr_button_link_to("/accept") { "Accept" } }
          message.action { helper.dsfr_link_to("View cookie policy", "/cookie-policy") }
        end
      end
    end

    specify "renders the message heading" do
      expect(rendered_content).to have_tag(message_selector) do
        with_tag("h2", text: custom_heading_text, with: { class: %w(govuk-cookie-banner__heading govuk-heading-m) })
      end
    end

    specify "applies the custom role" do
      expect(rendered_content).to have_tag(".govuk-cookie-banner") do
        with_tag("div", with: { class: "govuk-cookie-banner__message", role: custom_role })
      end
    end

    specify "renders the message text" do
      expect(rendered_content).to have_tag(message_selector) do
        with_tag("div", with: { class: "govuk-cookie-banner__content" }) do
          with_tag("p", text: custom_message_text, with: { class: "govuk-body" })
        end
      end
    end

    specify "renders the actions" do
      expect(rendered_content).to have_tag(".govuk-cookie-banner > .govuk-cookie-banner__message > div.fr-btn-group") do
        with_tag("a", with: { class: "fr-btn" }, count: 1)
      end
    end
  end

  it_behaves_like "a component that accepts custom classes"
  it_behaves_like "a component that accepts custom HTML attributes"
end

RSpec.describe(DsfrComponent::CookieBannerComponent::MessageComponent, type: :component) do
  let(:component_css_class) { "govuk-cookie-banner__message" }
  let(:custom_heading) { "Some heading" }
  let(:custom_text) { "Some message" }
  let(:kwargs) { { heading_text: custom_heading, text: custom_text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context "when there is no text or block" do
    specify "raises an appropriate error" do
      expect { render_inline(described_class.new(**kwargs.except(:text))) }.to raise_error(ArgumentError, "no text or content")
    end
  end

  context "when hidden: true" do
    subject! { render_inline(described_class.new(**kwargs.merge(hidden: true))) }

    specify "the message has a hidden attribute" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class, hidden: "hidden" })
    end
  end

  context "when there are blocks of HTML" do
    let(:custom_role) { "spam" }

    let(:custom_message_text) { "We need to track you!" }
    let(:custom_message_tag) { "em" }
    let(:custom_message_html) { helper.content_tag(custom_message_tag, custom_message_text) }

    let(:custom_heading_text) { "Wait a minute" }
    let(:custom_heading_tag) { "marquee" }
    let(:custom_heading_html) { helper.content_tag(custom_heading_tag, custom_heading_text) }

    subject! do
      render_inline(described_class.new(role: custom_role)) do |message|
        message.heading_html { custom_heading_html }

        helper.content_tag(custom_message_tag, custom_text)
      end
    end

    specify "the custom heading HTML is rendered" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class, role: custom_role }) do
        with_tag("h2", class: %w(govuk-cookie-banner__heading govuk-heading-m)) do
          with_tag(custom_heading_tag, text: custom_heading_text)
        end
      end
    end

    specify "the custom message HTML is rendered" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class, role: custom_role }) do
        with_tag("div", class: "govuk-cookie-banner__content") do
          with_tag(custom_message_tag, text: custom_text)
        end
      end
    end
  end
end
