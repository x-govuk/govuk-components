require 'spec_helper'

RSpec.describe(GovukComponent::InsetText, type: :component) do
  let(:text) { 'Bake him away, toys.' }
  let(:kwargs) { { text: text } }
  subject! { render_inline(GovukComponent::InsetText.new(**kwargs)) }

  specify 'contains a panel with the correct title and body text' do
    expect(page).to have_css('div', class: %w(govuk-inset-text), text: text)
  end

  it_behaves_like 'a component that accepts custom classes' do
    let(:component_class) { described_class }
  end
end
