require 'spec_helper'

RSpec.describe(GovukComponent::StartNowButton, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:kwargs) { { text: text, href: href } }

  let(:component) { GovukComponent::StartNowButton.new(**kwargs) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  specify 'contains a link styled as a button with the correct href' do
    expect(subject).to have_css('a', text: text, class: %w(govuk-button govuk-button--start)) do
      expect(page).to have_css('svg')
    end
  end

  context 'HTML attributes' do
    {
      'data-module' => 'govuk-button',
      'role' => 'button',
      'draggable' => 'false'
    }.each do |attribute, value|
      specify %(#{attribute} = '#{value}') do
        expect(subject.find('a')[attribute]).to eql(value)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
