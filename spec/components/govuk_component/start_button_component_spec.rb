require 'spec_helper'

RSpec.describe(GovukComponent::StartButtonComponent, type: :component) do
  let(:component_css_class) { 'govuk-button--start' }
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:kwargs) { { text: text, href: href } }

  subject! { render_inline(GovukComponent::StartButtonComponent.new(**kwargs)) }

  specify 'renders a link element with the right text and href' do
    expected_classes = %w(govuk-button govuk-button--start)
    expect(rendered_component).to have_tag('a', text: text, with: { class: expected_classes })
  end

  specify 'the link contains an SVG chevron' do
    expect(rendered_component).to have_tag('a') do
      with_tag('svg') { with_tag('path') }
    end
  end

  specify 'the link has the right attributes' do
    expected_attributes = {
      'data-module' => 'govuk-button',
      'role' => 'button',
      'draggable' => 'false'
    }

    expect(rendered_component).to have_tag('a', with: expected_attributes)
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
