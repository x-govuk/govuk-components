require 'spec_helper'

RSpec.describe(GovukComponent::Panel, type: :component) do
  let(:title_text) { 'Springfield' }
  let(:body_text) { 'A noble spirit embiggens the smallest man' }
  let(:kwargs) { { title: title_text, body: body_text } }
  subject! { render_inline(GovukComponent::Panel.new(**kwargs)).to_html }

  specify 'contains a panel with the correct title and body text' do
    expect(page).to have_css('div', class: %w(govuk-panel govuk-panel--confirmation)) do |panel|
      expect(panel).to have_css('h1', class: %w(govuk-panel__title), text: title_text)
      expect(panel).to have_css('div', class: %w(govuk-panel__body), text: body_text)
    end
  end

  it_behaves_like 'a component that accepts custom classes' do
    let(:component_class) { described_class }
  end
end
