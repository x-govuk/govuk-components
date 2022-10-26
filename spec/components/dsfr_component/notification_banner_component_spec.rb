require 'spec_helper'

RSpec.describe(DsfrComponent::NotificationBannerComponent, type: :component) do
  let(:component_css_class) { 'govuk-notification-banner' }
  let(:title) { 'A notification banner' }

  let(:kwargs) { { title_text: title, text: "something" } }

  describe 'slot arguments' do
    let(:slot) { :heading }
    let(:content) { -> { 'some swanky heading content' } }
    let(:slot_kwargs) { { text: 'some text', link_text: 'With a link', link_href: '#look-at-me' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'

    context "when supplied with a block" do
      subject! do
        render_inline(described_class.new(**kwargs)) do |component|
          component.heading(**slot_kwargs)
          component.heading(text: 'More text here')
          component.heading do
            helper.tag.p('some special content')
          end
        end
      end

      specify 'headings are rendered with content' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__content' }) do
          with_tag('div', with: { class: 'govuk-notification-banner__heading' }, text: /some text/) do
            with_tag('a', with: { class: 'govuk-notification-banner__link', href: '#look-at-me' }, text: 'With a link')
          end

          with_tag('div', with: { class: 'govuk-notification-banner__heading' }, text: 'More text here')

          with_tag('div', with: { class: 'govuk-notification-banner__heading' }) do
            with_tag('p', text: 'some special content')
          end
        end
      end
    end

    context "when supplied with some text" do
      let(:text) { "Some custom text" }
      let(:kwargs) { { title_text: title, text: text } }

      subject! { render_inline(described_class.new(**kwargs)) }

      specify 'headings are rendered with text' do
        expect(rendered_content).to have_tag('div', text: Regexp.new(text), with: { class: 'govuk-notification-banner__content' })
      end
    end

    describe 'generating a title with custom HTML' do
      let(:custom_text) { "Fancy title" }
      let(:custom_tag) { "span" }
      let(:custom_html) { helper.content_tag(custom_tag, custom_text) }

      subject! do
        render_inline(described_class.new(text: "Something")) do |component|
          component.title_html { custom_html }
        end
      end

      specify "the custom HTML is rendered in the title" do
        expect(rendered_content).to have_tag("h2", with: { class: "govuk-notification-banner__title" }) do
          with_tag(custom_tag, text: custom_text)
        end
      end
    end
  end

  describe 'roles' do
    context 'when default' do
      subject! { render_inline(described_class.new(**kwargs)) }

      specify %(renders a notification banner with the default role 'region') do
        expect(rendered_content).to have_tag("div", with: { role: 'region', class: component_css_class })
      end
    end

    context 'when succesful' do
      subject! { render_inline(described_class.new(**kwargs.merge(success: true))) }

      specify %(renders a notification banner with the default role 'alert') do
        expect(rendered_content).to have_tag("div", with: { role: 'alert', class: component_css_class })
      end
    end

    context 'when the role is overridden' do
      let(:custom_role) { "feed" }

      subject! do
        render_inline(described_class.new(**kwargs.merge(role: custom_role, text: "unnecessary")))
      end

      specify "renders a notification banner with the custom role" do
        expect(rendered_content).to have_tag("div", with: { role: custom_role, class: component_css_class })
      end
    end
  end

  # this is duplicated from the shared 'a component that accepts custom classes' because we
  # need a heading to be present for anything to render
  describe 'custom classes' do
    before do
      render_inline(described_class.new(**kwargs.merge(classes: custom_classes))) do |component|
        component.heading(text: 'A title')
      end
    end

    context 'when classes are supplied as a string' do
      let(:custom_classes) { 'purple-stripes' }

      context 'the custom classes should be set' do
        specify { expect(rendered_content).to have_tag("div", with: { class: custom_classes }) }
      end
    end

    context 'when classes are supplied as an array' do
      let(:custom_classes) { %w(purple-stripes yellow-background) }

      context 'the custom classes should be set' do
        specify { expect(rendered_content).to have_tag("div", with: { class: custom_classes }) }
      end
    end
  end

  describe 'custom html attributes' do
    before do
      render_inline(described_class.new(**kwargs)) do |component|
        component.heading(text: 'A title')
      end
    end

    describe 'overriding the role' do
      let(:custom_role) { 'alert' }
      let(:kwargs) { { title_text: title, html_attributes: { role: custom_role } } }

      specify 'replaces the default role with the provided one' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner', role: custom_role })
      end
    end
  end

  describe 'rendering a notification banner with headings' do
    before do
      render_inline(described_class.new(**kwargs)) do |component|
        component.heading(text: 'omg')
      end
    end

    specify 'renders the title' do
      expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__header' }) do
        with_tag('h2', with: { class: 'govuk-notification-banner__title', id: 'govuk-notification-banner-title' }, text: /#{title}/)
      end
    end

    specify 'renders the headings' do
      expect(rendered_content)
    end

    describe 'custom title heading levels' do
      let(:kwargs) { { title_text: title, title_heading_level: 4 } }

      specify 'the title has the specified heading level' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__header' }) do
          with_tag('h4', with: { class: 'govuk-notification-banner__title', id: 'govuk-notification-banner-title' }, text: /#{title}/)
        end
      end
    end

    describe 'custom title id' do
      let(:kwargs) { { title_text: title, title_id: 'custom-id' } }

      specify 'the title has the specified id' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__header' }) do
          with_tag('h2', with: { class: 'govuk-notification-banner__title', id: 'custom-id' }, text: /#{title}/)
        end
      end

      specify 'the notification banner is labelled by the title' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner', 'aria-labelledby' => 'custom-id' })
      end
    end

    describe 'custom heading content' do
      let(:heading_text) { 'What a nice heading' }

      before do
        render_inline(described_class.new(**kwargs)) do |component|
          component.heading { heading_text }
        end
      end

      specify 'the title has the custom content' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__content' }, text: heading_text)
      end

      context 'when custom content and heading text is provided' do
        before do
          render_inline(described_class.new(**kwargs)) do |component|
            component.heading(text: 'Some text') { heading_text }
          end
        end

        specify 'the text should take precedence over the block' do
          expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__content' }, text: 'Some text')
          expect(rendered_content).not_to have_tag('div', with: { class: 'govuk-notification-banner__content' }, text: heading_text)
        end
      end
    end

    context 'when disable_auto_focus is true' do
      let(:kwargs) { { title_text: title, disable_auto_focus: true } }

      specify 'auto focus is disabled' do
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner', 'data-disable-auto-focus' => 'true' })
      end
    end

    context 'when success is true' do
      let(:kwargs) { { title_text: title, success: true } }

      specify 'success class is appended' do
        expect(rendered_content).to have_tag('div', with: { class: %w(govuk-notification-banner govuk-notification-banner--success) })
      end
    end
  end

  describe 'rendering a notification banner with arbitrary content' do
    let(:additional_content) do
      helper.safe_join([helper.tag.p('The quick brown fox'), helper.tag.blockquote('Jumped over the lazy dog')])
    end

    before { render_inline(described_class.new(**kwargs)) { additional_content } }

    specify 'the additional content is rendered' do
      expect(rendered_content).to have_tag('div', with: { class: 'govuk-notification-banner__content' }) do
        with_tag('p', text: 'The quick brown fox')
        with_tag('blockquote', text: 'Jumped over the lazy dog')
      end
    end
  end
end
