require 'spec_helper'

RSpec.describe(GovukComponent::PanelComponent, type: :component) do
  include_context 'helpers'
  include_context 'setup'

  let(:component_css_class) { 'govuk-panel.govuk-panel--confirmation' }

  let(:title) { 'Springfield' }
  let(:text) { 'A noble spirit embiggens the smallest man' }
  let(:kwargs) { { title: title, text: text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  specify 'contains a panel with the correct title and text' do
    render_inline(described_class.new(**kwargs))

    expect(rendered_component).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
      with_tag('h1', with: { class: 'govuk-panel__title' }, text: title)
      with_tag('div', with: { class: 'govuk-panel__body' }, text: text)
    end
  end

  context 'when no title is supplied' do
    before { render_inline(described_class.new(**kwargs.except(:title))) }

    specify 'contains a panel with no title and the text' do
      expect(rendered_component).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
        without_tag('h1', with: { class: 'govuk-panel__title' }, text: title)
        with_tag('div', with: { class: 'govuk-panel__body' }, text: text)
      end
    end
  end

  context 'with a custom heading level' do
    let(:custom_heading_level) { 3 }
    before { render_inline(described_class.new(**kwargs.merge(heading_level: custom_heading_level))) }

    specify 'contains a panel with the title and no text' do
      expect(rendered_component).to have_tag(%(h#{custom_heading_level}), with: { class: 'govuk-panel__title' }, text: title)
    end
  end

  context 'when no text is supplied' do
    before { render_inline(described_class.new(**kwargs.except(:text))) }

    specify 'contains a panel with the title and no text' do
      expect(rendered_component).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
        with_tag('h1', with: { class: 'govuk-panel__title' }, text: title)
        without_tag('div', with: { class: 'govuk-panel__body' }, text: text)
      end
    end
  end

  context 'when a block is supplied' do
    before { render_inline(described_class.new(**kwargs.except(:title))) { helper.tag.div('Something in a block') } }

    specify 'contains a panel with no title and the block' do
      expect(rendered_component).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
        without_tag('h1', with: { class: 'govuk-panel__title' }, text: title)
        with_tag('div', with: { class: 'govuk-panel__body' }) do
          with_tag('div', text: 'Something in a block')
        end
      end
    end
  end

  context 'when no arguments are supplied' do
    before { render_inline(described_class.new) }

    specify 'nothing is rendered' do
      expect(rendered_component).to be_blank
    end
  end
end
