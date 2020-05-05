require 'spec_helper'

RSpec.describe(StartNowButton::StartNowButtonComponent, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:component) { StartNowButton::StartNowButtonComponent.new(text: text, href: href) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  specify 'should have a title and body with the correct contents' do
    expect(subject).to have_css('a', text: text, class: %w(govuk-button govuk-button--start)) do
      expect(page).to have_css('svg')
    end
  end
end
