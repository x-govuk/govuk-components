require 'spec_helper'

RSpec.describe(GovukComponent::NotificationBanner, type: :component) do
  include_context 'helpers'

  let(:title) { "A notification banner" }
  let(:heading) { "Something amazing has happened." }
  let(:additional_content) do
    helper.safe_join(
      [
        helper.tag.p("The quick brown fox"),
        helper.tag.blockquote("Jumped over the lazy dog")
      ]
    )
  end

  let(:kwargs) { { title: title, heading: heading } }

  describe "rendering a notification banner" do
    before do
      render_inline(GovukComponent::NotificationBanner.new(**kwargs)) { additional_content }
    end

    let(:subject) { page }

    it { is_expected.to have_css('div.govuk-notification-banner') }

    specify "includes the title" do
      expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__header") do |header|
        expect(header).to have_css("h2.govuk-notification-banner__title", text: title)
      end
    end

    specify "includes the heading" do
      expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__content") do |content|
        expect(content).to have_css("p.govuk-notification-banner__heading", text: heading)
      end
    end

    context "when a link is provided" do
      let(:link_target) { "/some/fancy/page" }
      let(:link_text) { "A very fancy page indeed" }

      let(:kwargs) { { title: title, heading: heading, link_text: link_text, link_target: link_target } }

      specify "should render the link after the heading" do
        expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__content") do |content|
          expect(content).to have_css("p.govuk-notification-banner__heading", text: [heading, link_text].join(" "))
          expect(content).to have_link(link_text, href: link_target)
        end
      end
    end

    context "when successful" do
      let(:kwargs) { { title: title, heading: heading, success: true } }

      it { is_expected.to have_css('div.govuk-notification-banner.govuk-notification-banner--success') }
    end

    context "additional content" do
      specify "is included in the banner content" do
        expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__content") do |content|
          expect(content).to have_css("p", text: "The quick brown fox")
          expect(content).to have_css("blockquote", text: "Jumped over the lazy dog")
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
