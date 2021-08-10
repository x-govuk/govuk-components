require 'spec_helper'

RSpec.describe(GovukComponent::BackLinkComponent, type: :component) do
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:kwargs) { { text: text, href: href } }
  let(:component_css_class) { 'govuk-back-link' }

  subject! { render_inline(GovukComponent::BackLinkComponent.new(**kwargs)) }

  specify 'renders a link with the right href and text' do
    expect(rendered_component).to have_tag('a', text: text, with: { href: href, class: component_css_class })
  end

  context 'when link text is provided via a block' do
    let(:custom_text) { "Some text" }
    let(:custom_tag) { :code }
    subject! do
      render_inline(GovukComponent::BackLinkComponent.new(href: href)) do
        helper.content_tag(custom_tag, custom_text)
      end
    end

    specify 'renders the component with custom tag and text' do
      expect(rendered_component).to have_tag('a', with: { href: href, class: component_css_class }) do
        with_tag(custom_tag, text: custom_text)
      end
    end
  end

  context "when neither text or a block is supplied" do
    specify "raises an appropriate error" do
      expect {
        render_inline(GovukComponent::BackLinkComponent.new(href: href))
      }.to raise_error(ArgumentError, "no text or content")
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
