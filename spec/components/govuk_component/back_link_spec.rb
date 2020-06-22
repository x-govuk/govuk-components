require 'spec_helper'

RSpec.describe(GovukComponent::BackLink, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:node) { Capybara::Node::Simple.new(render_inline(component).to_html) }

  context 'default behaviour' do
    let(:component) { GovukComponent::BackLink.new(text: text, href: href) }

    specify 'contains a link styled as a back link with the correct href' do
      expect(node).to have_css('a', text: text, class: %w(govuk-back-link))
    end
  end

  it_behaves_like 'a component that accepts custom classes' do
    let(:component_class) { GovukComponent::BackLink }
    let(:kwargs) { { text: text, href: href } }
  end

  context 'accepts custom HTML attributes' do
    let(:component) {
      GovukComponent::BackLink.new(text: text, href: href,
                                   attributes: { data_html5: 'Attributes',
                                                 id: 'my-back-link'})
    }

    specify 'contains a link styled as a back link with custom html attributes' do
      expect(node).to have_css('a', text: text, id: 'my-back-link')
    end
  end

  context 'accepts custom css classes and multiple HTML attributes' do
    let(:component) {
      GovukComponent::BackLink.new(text: text, href: href, classes: 'app-style',
                                   attributes: { data_html5: 'Attributes',
                                                 id: 'my-back-link',
                                                 data: { tag: 'element'} })
    }

    specify 'contains a link styled as a back link with custom html attributes' do
      expect(node).to have_css('a#my-back-link.app-style[data-tag="element"]',
                                  text: text)
    end
  end

end
