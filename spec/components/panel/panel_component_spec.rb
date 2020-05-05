require 'spec_helper'

RSpec.describe(Panel::PanelComponent, type: :component) do
  let(:title_text) { 'Springfield' }
  let(:body_text) { 'A noble spirit embiggens the smallest man' }
  let(:component) { Panel::PanelComponent.new(title: title_text, body: body_text) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  specify 'should have a title and body with the correct contents' do
    expect(subject).to have_css('div', class: %w(govuk-panel govuk-panel--confirmation)) do
      expect(page).to have_css('h1', class: %w(govuk-panel__title), text: title_text)
      expect(page).to have_css('div', class: %w(govuk-panel__body), text: body_text)
    end
  end
end
