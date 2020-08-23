require 'spec_helper'

RSpec.describe(GovukComponent::Details, type: :component) do
  let(:summary) { 'The new Ribwich' }
  let(:description) { %(You're way off. Think smaller, and more legs.) }
  let(:kwargs) { { description: description, summary: summary } }

  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  context 'when a description is supplied' do
    let(:description) { 'Now without lettuce' }

    subject! { render_inline(GovukComponent::Details.new(**kwargs)) }

    specify 'contains a details element with the correct summary and description' do
      expect(page).to have_css('details', class: %w(govuk-details)) do |details|
        expect(details).to have_css('summary.govuk-details__summary > span.govuk-details__summary-text', text: summary)
        expect(details).to have_css('div.govuk-details__text', text: description, visible: false)
      end
    end
  end

  context 'when a block is supplied' do

    subject! do
      render_inline(GovukComponent::Details.new(**kwargs.except(:description))) { description }
    end

    specify 'contains a details element with the correct summary and description' do
      expect(page).to have_css('details', class: %w(govuk-details)) do |details|
        expect(details).to have_css('summary.govuk-details__summary > span.govuk-details__summary-text', text: summary)
        expect(details).to have_css('div.govuk-details__text', text: description, visible: false)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes' do
    let(:component_class) { described_class }
  end
end
