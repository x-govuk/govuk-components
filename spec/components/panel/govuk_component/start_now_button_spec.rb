require 'spec_helper'

RSpec.describe(GovukComponent::StartNowButton, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:component) { GovukComponent::StartNowButton.new(text: text, href: href) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  specify 'contains a link styled as a button with the correct href' do
    expect(subject).to have_css('a', text: text, class: %w(govuk-button govuk-button--start)) do
      expect(page).to have_css('svg')
    end
  end
end
