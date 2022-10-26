require 'spec_helper'

RSpec.describe(DsfrComponent::PanelComponent, type: :component) do
  let(:component_css_class) { 'govuk-panel' }

  let(:title_text) { 'Springfield' }
  let(:text) { 'A noble spirit embiggens the smallest man' }
  let(:kwargs) { { title_text: title_text, text: text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  specify 'contains a panel with the correct title and text' do
    render_inline(described_class.new(**kwargs))

    expect(rendered_content).to have_tag('div', with: { class: %w(govuk-panel govuk-panel--confirmation) }) do
      with_tag('h1', with: { class: 'govuk-panel__title' }, text: title_text)
      with_tag('div', with: { class: 'govuk-panel__body' }, text: text)
    end
  end

  context 'when title_html is provided instead of title_text' do
    let(:custom_tag) { "h5" }
    let(:custom_title_text) { "I'm a title" }
    before do
      render_inline(described_class.new(**kwargs.except(:title_text))) do |component|
        component.title_html { helper.content_tag(custom_tag, custom_title_text) }
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
        with_tag('div', with: { class: 'govuk-panel__body' }, text: text)
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
        without_tag('div', with: { class: 'govuk-panel__body' }, text: text)
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
end
