require 'spec_helper'

RSpec.describe(DsfrComponent::BackLinkComponent, type: :component) do
  let(:default_text) { 'Back' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:kwargs) { { href: href } }
  let(:component_css_class) { 'govuk-back-link' }

  subject! { render_inline(DsfrComponent::BackLinkComponent.new(**kwargs)) }

  specify 'renders a link with the right href and text' do
    expect(rendered_content).to have_tag('a', text: default_text, with: { href: href, class: component_css_class })
  end

  context 'when custom text is provided via the text argument' do
    let(:custom_text) { 'Department for Education' }
    let(:kwargs) { { href: href, text: custom_text } }

    specify 'renders the component with custom text' do
      expect(rendered_content).to have_tag('a', with: { href: href, class: component_css_class }, text: custom_text)
    end
  end

  context 'when link text is provided via a block' do
    let(:custom_text) { "Some text" }
    let(:custom_tag) { :code }
    subject! do
      render_inline(DsfrComponent::BackLinkComponent.new(href: href)) do
        helper.content_tag(custom_tag, custom_text)
      end
    end

    specify 'renders the component with custom tag and text' do
      expect(rendered_content).to have_tag('a', with: { href: href, class: component_css_class }) do
        with_tag(custom_tag, text: custom_text)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
