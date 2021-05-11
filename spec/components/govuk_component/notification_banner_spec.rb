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

  describe "rendering a notification banner with headings" do
    before do
      render_inline(GovukComponent::NotificationBanner.new(**kwargs)) do |nb|
        nb.heading(text: "omg")
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

    describe "custom title heading levels" do
      let(:custom_level) { 4 }
      let(:kwargs) { { title: title, title_heading_level: custom_level } }

      specify "the title has the specified heading level" do
        expect(subject).to have_css("h#{custom_level}", text: title)
      end
    end

    describe "customising the title id" do
      let(:custom_id) { 'my-id' }
      let(:kwargs) { { title: title, title_id: custom_id } }

      specify "the title has the specified id" do
        expect(subject).to have_css("h2##{custom_id}", text: title)
      end

      specify "the notification banner is labelled by the title" do
        expect(subject).to have_css(%(div.govuk-notification-banner[aria-labelledby="#{custom_id}"]))
      end
    end

    describe "custom HTML heading content" do
      let(:heading_text) { "What a nice heading" }
      before do
        render_inline(GovukComponent::NotificationBanner.new(**kwargs)) do |nb|
          nb.heading { heading_text }
        end
      end

      specify "the title has the custom content" do
        expect(subject).to have_css("p", text: heading_text)
      end

      context "when custom HTML and heading text is provided" do
        let(:block_content) { "should not be rendered" }
        before do
          render_inline(GovukComponent::NotificationBanner.new(**kwargs)) do |nb|
            nb.heading(text: heading_text) { block_content }
          end
        end

        specify "the text should take precedence over the block" do
          expect(subject).to have_css("p", text: heading_text)
          expect(subject).not_to have_content(block_content)
        end
      end
    end

    describe "when disable_auto_focus is true" do
      let(:custom_id) { 'my-id' }
      let(:kwargs) { { title: title, disable_auto_focus: true } }

      specify "auto focus is disabled" do
        expect(subject).to have_css(%(div.govuk-notification-banner[data-disable-auto-focus="true"]))
      end
    end

    describe "headings" do
      let(:heading_one) { "Heading one" }
      let(:heading_two) { "Heading two" }
      before do
        render_inline(described_class.send(:new, **kwargs)) do |nb|
          nb.heading(text: heading_one)
          nb.heading(text: heading_two)
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
          nb.heading(text: heading, link_text: link_text, link_target: link_target)
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
          nb.heading(text: "A title")
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

    describe "custom html attributes" do
      before do
        render_inline(described_class.send(:new, **kwargs)) do |nb|
          nb.heading(text: "A title")
        end
      end

      describe "overriding the role" do
        let(:custom_role) { "alert" }
        let(:kwargs) { { title: title, html_attributes: { role: custom_role } } }

        specify 'does the thing' do
          expect(page).to have_css("div.govuk-notification-banner[role='#{custom_role}']")
        end
      end
    end

    context 'slot arguments' do
      let(:slot) { :heading }
      let(:content) { -> { "some swanky heading content" } }
      let(:slot_kwargs) { { text: "some heading text" } }

      it_behaves_like 'a component with a slot that accepts custom classes'
      it_behaves_like 'a component with a slot that accepts custom html attributes'
    end

    it_behaves_like 'a component with a DSL wrapper' do
      let(:helper_name) { 'govuk_notification_banner' }
      let(:wrapped_slots) { %i(heading) }

      let(:expected_css) { '.govuk-notification-banner' }

      let(:block) { ->(banner) { banner.add_heading(text: "What a nice heading!") } }
    end
  end

  describe "rendering a notification banner with arbitrary content" do
    before do
      render_inline(GovukComponent::NotificationBanner.new(**kwargs)) { additional_content }
    end

    let(:subject) { page }

    specify "the extra banner with extra content is rendered" do
      expect(subject).to have_css(".govuk-notification-banner > .govuk-notification-banner__content") do |content|
        expect(content).to have_css("p", text: "The quick brown fox")
        expect(content).to have_css("blockquote", text: "Jumped over the lazy dog")
      end
    end
  end
end
