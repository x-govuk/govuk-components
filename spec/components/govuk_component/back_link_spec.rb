require 'spec_helper'

RSpec.describe(GovukComponent::BackLink, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }

  context 'default behaviour' do
    let(:component) { GovukComponent::BackLink.new(text: text, href: href) }
    subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

    specify 'contains a link styled as a back link with the correct href' do
      expect(subject).to have_css('a', text: text, class: %w(govuk-back-link))
    end
  end

  context 'accepts custom css classes' do
    let(:component) {
      GovukComponent::BackLink.new(text: text, href: href,
                                   classes: 'app-custom--class app-custom--class-2')
    }
    subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

    specify 'contains a link styled as a back link with the correct href' do
      expect(subject).to have_css('a', text: text, class: %w(govuk-back-link app-custom--class app-custom--class-2))
    end
  end
end
