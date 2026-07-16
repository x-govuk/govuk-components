require 'spec_helper'

RSpec.describe(GovukComponent::PanelComponent, type: :component) do
  let(:component_css_class) { 'govuk-panel' }

  let(:title_text) { 'Springfield' }
  let(:text) { 'A noble spirit embiggens the smallest man' }
  let(:interruption_mode) { false }
  let(:kwargs) { { title_text:, text:, interruption: interruption_mode } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'

  specify 'contains a panel with the correct title and text' do
    render_inline(described_class.new(**kwargs))

    expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
      with_tag('h1', with: { class: 'govuk-panel__title' }, text: title_text)
      with_tag('div', with: { class: 'govuk-panel__body' }, text:)
    end
  end

  context 'when title_html is provided instead of title_text' do
    let(:custom_tag) { "h5" }
    let(:custom_title_text) { "I'm a title" }
    before do
      render_inline(described_class.new(**kwargs.except(:title_text))) do |component|
        component.with_title_html { helper.content_tag(custom_tag, custom_title_text) }
      end
    end

    specify "the custom HTMl is rendered" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class }) do
        with_tag(custom_tag, text: custom_title_text)
      end
    end
  end

  context 'when a custom id is supplied' do
    let(:custom_id) { "fancy-id" }

    before { render_inline(described_class.new(**kwargs.merge(id: custom_id))) }

    specify 'renders the panel with the custom id' do
      expect(rendered_content).to have_tag('div', with: { id: custom_id, class: component_css_class })
    end
  end

  context 'when no title is supplied' do
    before { render_inline(described_class.new(**kwargs.except(:title_text))) }

    specify 'contains a panel with no title and the text' do
      expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
        without_tag('h1', with: { class: 'govuk-panel__title' }, text: title_text)
        with_tag('div', with: { class: 'govuk-panel__body' }, text:)
      end
    end
  end

  context 'with a custom heading level' do
    let(:custom_heading_level) { 3 }
    before { render_inline(described_class.new(**kwargs.merge(heading_level: custom_heading_level))) }

    specify 'contains a panel with the title and no text' do
      expect(rendered_content).to have_tag(%(h#{custom_heading_level}), with: { class: 'govuk-panel__title' }, text: title_text)
    end
  end

  context 'when no text is supplied' do
    before { render_inline(described_class.new(**kwargs.except(:text))) }

    specify 'contains a panel with the title and no text' do
      expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
        with_tag('h1', with: { class: 'govuk-panel__title' }, text: title_text)
        without_tag('div', with: { class: 'govuk-panel__body' }, text:)
      end
    end
  end

  context 'when a block is supplied' do
    before { render_inline(described_class.new(**kwargs.except(:title_text))) { helper.tag.div('Something in a block') } }

    specify 'contains a panel with no title and the block' do
      expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
        without_tag('h1', with: { class: 'govuk-panel__title' }, text: title_text)
        with_tag('div', with: { class: 'govuk-panel__body' }) do
          with_tag('div', text: 'Something in a block')
        end
      end
    end
  end

  context 'when no arguments are supplied' do
    before { render_inline(described_class.new) }

    specify 'nothing is rendered' do
      expect(rendered_content).to be_blank
    end
  end

  context 'when in interruption: true' do
    let(:interruption_mode) { true }

    specify 'renders interruption panel' do
      render_inline(described_class.new(**kwargs))

      expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--interruption) })
    end

    context 'when actions are present' do
      describe 'buttons' do
        specify 'actions are inverse buttons by default and rendered in a actions div within the panel' do
          render_inline(described_class.new(**kwargs)) do |component|
            component.with_action(text: "Yes", href: "#")
          end

          expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--interruption) }) do
            with_tag('div', with: { class: 'govuk-panel__actions' }) do
              with_tag('a', text: 'Yes', with: { href: '#', class: %w(govuk-button govuk-button--inverse) })
            end
          end
        end
      end

      describe 'links' do
        specify 'links are inverse links rendered in a actions div within the panel' do
          render_inline(described_class.new(**kwargs)) do |component|
            component.with_action(text: "No", href: "#", type: :link)
          end

          expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--interruption) }) do
            with_tag('div', with: { class: 'govuk-panel__actions' }) do
              with_tag('a', text: 'No', with: { href: '#', class: %w(govuk-link govuk-link--inverse) })
            end
          end
        end

        specify 'passing the type in as a string works too' do
          render_inline(described_class.new(**kwargs)) do |component|
            component.with_action(text: "No", href: "#", type: 'link')
          end

          expect(rendered_content).to have_tag('a', text: 'No', with: { href: '#', class: %w(govuk-link govuk-link--inverse) })
        end
      end

      describe 'invalid types' do
        specify 'links are inverse links rendered in a actions div within the panel' do
          expect {
            render_inline(described_class.new(**kwargs)) do |component|
              component.with_action(text: "No", href: "#", type: :other)
            end
          }.to raise_error(ArgumentError, 'unrecognised type (must be :link or :button)')
        end
      end

      context 'when not in interruption mode' do
        let(:interruption_mode) { false }

        before do
          allow(Rails.logger).to receive(:warn).and_call_original

          render_inline(described_class.new(**kwargs)) do |component|
            component.with_action(text: "Yes", href: "#")
          end
        end

        specify 'no actions are rendered' do
          expect(rendered_content).not_to have_tag('div', with: { class: 'govuk-panel__actions' })
        end

        specify 'a warning is logged' do
          expect(Rails.logger).to have_received(:warn).with(%(Actions will not be rendered unless the panel is in interruption mode))
        end
      end
    end
  end
end
