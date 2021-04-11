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

  context 'when no title is supplied' do
    let(:kwargs) { { body: body_text } }

    specify 'renders a panel with a body but no title' do
      expect(page).to have_css('div', class: %w(govuk-panel govuk-panel--confirmation)) do |panel|
        expect(panel).not_to have_css('h1', class: %w(govuk-panel__title))
        expect(panel).to have_css('div', class: %w(govuk-panel__body), text: body_text)
      end
    end
  end

  context 'when no body is supplied' do
    let(:kwargs) { { title: title_text } }

    specify 'renders a panel with a title but no body' do
      expect(page).to have_css('div', class: %w(govuk-panel govuk-panel--confirmation)) do |panel|
        expect(panel).to have_css('h1', class: %w(govuk-panel__title), text: title_text)
        expect(panel).not_to have_css('div', class: %w(govuk-panel__body))
      end
    end
  end

  context 'when a block is supplied' do
    let(:custom_panel_body) { "some text" }
    subject! do
      render_inline(GovukComponent::Panel.new(**kwargs.except(:body))) { custom_panel_body }
    end

    specify 'contains a details element with the correct summary and description' do
      expect(page).to have_css('div', class: %w(govuk-panel__body), text: custom_panel_body)
    end
  end

  context 'when no arguments are supplied' do
    subject! { render_inline(GovukComponent::Panel.new) }

    specify 'nothing is rendered' do
      expect(rendered_component).to be_empty
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
