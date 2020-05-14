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
      expect(subject).to have_css('a',
                                  text: text,
                                  class: %w(govuk-back-link app-custom--class app-custom--class-2))
    end
  end

  context 'accepts custom HTML attributes' do
    let(:component) {
      GovukComponent::BackLink.new(text: text, href: href,
                                   attributes: { data_html5: 'Attributes',
                                                 id: 'my-back-link'})
    }
    subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

    specify 'contains a link styled as a back link with custom html attributes' do
      expect(subject).to have_css('a', text: text, id: 'my-back-link')
    end
  end

  context 'accepts custom css classes and multiple HTML attributes' do
    let(:component) {
      GovukComponent::BackLink.new(text: text, href: href, classes: 'app-style',
                                   attributes: { data_html5: 'Attributes',
                                                 id: 'my-back-link',
                                                 data: { tag: 'element'} })
    }
    subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

    specify 'contains a link styled as a back link with custom html attributes' do
      expect(subject).to have_css('a#my-back-link.app-style[data-tag="element"]',
                                  text: text)
    end
  end

end
