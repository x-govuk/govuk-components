require 'spec_helper'

RSpec.describe(GovukComponent::NotificationBanner, type: :component) do
  include_context 'helpers'

  let(:title) { "A notification banner" }
  let(:additional_content) do
    helper.safe_join(
      [
        helper.tag.p("The quick brown fox"),
        helper.tag.blockquote("Jumped over the lazy dog")
      ]
    )
  end

  let(:kwargs) { { title: title } }

  describe "rendering a notification banner" do
    before do
      render_inline(GovukComponent::NotificationBanner.new(**kwargs)) do |nb|
        nb.slot(:heading, text: "omg")
        additional_content
      end
    end

    let(:subject) { page }

    it { is_expected.to have_css('div.govuk-notification-banner') }

    specify "includes the title" do
      expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__header") do |header|
        expect(header).to have_css("h2.govuk-notification-banner__title", text: title)
      end
    end

    describe "headings" do
      let(:heading_one) { "Heading one" }
      let(:heading_two) { "Heading two" }
      before do
        render_inline(described_class.send(:new, **kwargs)) do |nb|
          nb.slot(:heading, text: heading_one)
          nb.slot(:heading, text: heading_two)
        end
      end

      specify "includes all provided headings" do
        expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__content") do |content|
          expect(content).to have_css("p.govuk-notification-banner__heading", text: heading_one)
          expect(content).to have_css("p.govuk-notification-banner__heading", text: heading_two)
        end
      end
    end

    describe "headings with links" do
      let(:heading) { "Heading one" }
      let(:link_target) { "/some/fancy/page" }
      let(:link_text) { "A very fancy page indeed" }

      before do
        render_inline(described_class.send(:new, **kwargs)) do |nb|
          nb.slot(:heading, text: heading, link_text: link_text, link_target: link_target)
        end
      end

      specify "should render the link after the heading" do
        expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__content") do |content|
          expect(content).to have_css("p.govuk-notification-banner__heading", text: /#{heading}/) do |div|
            expect(div).to have_link(link_text, href: link_target)
          end
        end
      end
    end

    context "when successful" do
      let(:kwargs) { { title: title, success: true } }

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


    # this is duplicated from the shared 'a component that accepts custom classes' because we
    # need a heading to be present for anything to render
    describe "custom classes and attributes" do
      before do
        render_inline(described_class.send(:new, **kwargs.merge(classes: custom_classes))) do |nb|
          nb.slot(:heading, text: "A title")
        end
      end

      context 'when classes are supplied as a string' do
        let(:custom_classes) { 'purple-stripes' }

        context 'the custom classes should be set' do
          specify { expect(page).to have_css(".#{custom_classes}") }
        end
      end

      context 'when classes are supplied as an array' do
        let(:custom_classes) { %w(purple-stripes yellow-background) }

        context 'the custom classes should be set' do
          specify { expect(page).to have_css(".#{custom_classes.join('.')}") }
        end
      end
    end
  end
end
