require 'spec_helper'

RSpec.describe(GovukComponent::InsetTextComponent, type: :component) do
  include_context 'helpers'
  include_context 'setup'

  let(:component_css_class) { 'govuk-inset-text' }

  let(:text) { 'Bake him away, toys.' }
  let(:kwargs) { { text: text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'when text is supplied' do
    before { render_inline(described_class.new(**kwargs)) }

    specify 'the text is rendered' do
      expect(rendered_component).to have_tag('div', with: { class: 'govuk-inset-text' }, text: text)
    end
  end

  context 'when a block is supplied' do
    before { render_inline(described_class.new(**kwargs)) { 'Something in a block' } }

    specify 'the block is rendered' do
      expect(rendered_component).to have_tag('div', with: { class: 'govuk-inset-text' }, text: 'Something in a block')
    end
  end

  context 'when neither a block or text are supplied' do
    before { render_inline(described_class.new(**kwargs.except(:text))) }

    specify 'nothing is rendered' do
      expect(rendered_component).to be_blank
    end
  end
end
