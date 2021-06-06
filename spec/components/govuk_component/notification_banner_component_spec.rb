require 'spec_helper'

RSpec.describe(GovukComponent::NotificationBannerComponent, type: :component) do
  include_context 'helpers'
  include_context 'setup'

  let(:component_css_class) { 'govuk-notification-banner' }
  let(:title) { 'A notification banner' }

  let(:kwargs) { { title: title } }

  describe 'slot arguments' do
    let(:slot) { :heading }
    let(:content) { -> { 'some swanky heading content' } }
    let(:slot_kwargs) { { text: 'some text', link_text: 'With a link', link_href: '#look-at-me' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'

    specify 'headings are rendered with text or content' do
      render_inline(described_class.new(**kwargs)) do |component|
        component.heading(**slot_kwargs)
        component.heading(text: 'More text here')
        component.heading do
          helper.tag.p('some special content')
        end
      end

      expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__content' }) do
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

  describe 'custom html attributes' do
    before do
      render_inline(described_class.new(**kwargs)) do |component|
        component.heading(text: 'A title')
      end
    end

    describe 'overriding the role' do
      let(:custom_role) { 'alert' }
      let(:kwargs) { { title: title, html_attributes: { role: custom_role } } }

      specify 'does the thing' do
        expect(page).to have_css("div.govuk-notification-banner[role='#{custom_role}']")
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
      expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__header' }) do
        with_tag('h2', with: { class: 'govuk-notification-banner__title', id: 'govuk-notification-banner-title' }, text: /#{title}/)
      end
    end

    specify 'renders the headings' do
      expect(rendered_component)
    end

    describe 'custom title heading levels' do
      let(:kwargs) { { title: title, title_heading_level: 4 } }

      specify 'the title has the specified heading level' do
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__header' }) do
          with_tag('h4', with: { class: 'govuk-notification-banner__title', id: 'govuk-notification-banner-title' }, text: /#{title}/)
        end
      end
    end

    describe 'custom title id' do
      let(:kwargs) { { title: title, title_id: 'custom-id' } }

      specify 'the title has the specified id' do
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__header' }) do
          with_tag('h2', with: { class: 'govuk-notification-banner__title', id: 'custom-id' }, text: /#{title}/)
        end
      end

      specify 'the notification banner is labelled by the title' do
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner', 'aria-labelledby' => 'custom-id' })
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
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__content' }, text: heading_text)
      end

      context 'when custom content and heading text is provided' do
        before do
          render_inline(described_class.new(**kwargs)) do |component|
            component.heading(text: 'Some text') { heading_text }
          end
        end

        specify 'the text should take precedence over the block' do
          expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__content' }, text: 'Some text')
          expect(rendered_component).not_to have_tag('div', with: { class: 'govuk-notification-banner__content' }, text: heading_text)
        end
      end
    end

    context 'when disable_auto_focus is true' do
      let(:kwargs) { { title: title, disable_auto_focus: true } }

      specify 'auto focus is disabled' do
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner', 'data-disable-auto-focus' => 'true' })
      end
    end

    context 'when success is true' do
      let(:kwargs) { { title: title, success: true } }

      specify 'success class is appended' do
        expect(rendered_component).to have_tag('div', with: { class: %w(govuk-notification-banner govuk-notification-banner--success) })
      end
    end
  end

  describe 'rendering a notification banner with arbitrary content' do
    let(:additional_content) do
      helper.safe_join([helper.tag.p('The quick brown fox'), helper.tag.blockquote('Jumped over the lazy dog')])
    end

    before { render_inline(described_class.new(**kwargs)) { additional_content } }

    specify 'the additional content is rendered' do
      expect(rendered_component).to have_tag('div', with: { class: 'govuk-notification-banner__content' }) do
        with_tag('p', text: 'The quick brown fox')
        with_tag('blockquote', text: 'Jumped over the lazy dog')
      end
    end
  end
end
