require 'spec_helper'

RSpec.describe(GovukComponent::BackLinkComponent, type: :component, version: 2) do
  include_context 'setup'

  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:kwargs) { { text: text, href: href } }
  let(:component_css_class) { 'govuk-back-link' }

  subject! { render_inline(GovukComponent::BackLinkComponent.new(**kwargs)) }

  specify 'renders a link with the right href and text' do
    expect(rendered_component).to have_tag('a', text: text, with: { href: href, class: component_css_class })
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
