require 'spec_helper'

RSpec.describe(GovukComponent::InsetText, type: :component) do
  include_context 'helpers'

  let(:text) { 'Bake him away, toys.' }
  let(:kwargs) { { text: text } }
  subject! { render_inline(GovukComponent::InsetText.new(**kwargs)) }

  specify 'contains a panel with the correct title and body text' do
    expect(page).to have_css('div', class: %w(govuk-inset-text), text: text)
  end

  context 'when provided with HTML content' do
    subject! do
      render_inline(GovukComponent::InsetText.new) { helper.tag.span(text) }
    end

    specify 'the content is rendered' do
      expect(page).to have_css('span', text: text)
    end
  end

  context 'when no block or text is provided' do
    subject! do
      render_inline(GovukComponent::InsetText.new)
    end

    specify 'nothing is rendered' do
      expect(rendered_component).to be_blank
    end
  end

  it_behaves_like 'a component that accepts custom classes' do
    let(:component_class) { described_class }
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
