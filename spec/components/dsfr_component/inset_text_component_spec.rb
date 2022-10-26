require 'spec_helper'

RSpec.describe(DsfrComponent::InsetTextComponent, type: :component) do
  let(:component_css_class) { 'govuk-inset-text' }

  let(:text) { 'Bake him away, toys.' }
  let(:kwargs) { { text: text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'when text is supplied' do
    before { render_inline(described_class.new(**kwargs)) }

    specify 'the text is rendered' do
      expect(rendered_content).to have_tag('div', with: { class: component_css_class }, text: text)
    end
  end

  context 'when a block is supplied' do
    before { render_inline(described_class.new(**kwargs)) { 'Something in a block' } }

    specify 'the block is rendered' do
      expect(rendered_content).to have_tag('div', with: { class: component_css_class }, text: 'Something in a block')
    end
  end

  context 'when neither a block or text are supplied' do
    before { render_inline(described_class.new(**kwargs.except(:text))) }

    specify 'nothing is rendered' do
      expect(rendered_content).to be_blank
    end
  end

  context 'when a custom id is supplied' do
    let(:custom_id) { 'abc123' }
    before { render_inline(described_class.new(**kwargs.merge(id: custom_id))) }

    specify 'the text is rendered with the custom id' do
      expect(rendered_content).to have_tag('div', with: { id: custom_id, class: component_css_class }, text: text)
    end
  end
end
