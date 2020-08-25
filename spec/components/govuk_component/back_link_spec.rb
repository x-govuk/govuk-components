require 'spec_helper'

RSpec.describe(GovukComponent::BackLink, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:kwargs) { { text: text, href: href } }

  context 'default behaviour' do
    before { render_inline(GovukComponent::BackLink.new(**kwargs)) }

    specify 'contains a link styled as a back link with the correct href' do
      expect(page).to have_css('a', text: text, class: %w(govuk-back-link))
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
