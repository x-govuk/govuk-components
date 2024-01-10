require 'spec_helper'

RSpec.describe(GovukComponent::StartButtonComponent, type: :component) do
  let(:component_css_class) { 'govuk-button--start' }
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:as_button) { false }
  let(:kwargs) { { text:, href:, as_button: } }

  before do
    allow_any_instance_of(GovukComponent::StartButtonComponent)
      .to(receive(:protect_against_forgery?).and_return(false))
  end

  subject! { render_inline(GovukComponent::StartButtonComponent.new(**kwargs)) }

  context 'as a link' do
    specify 'renders a link element with the right text and href' do
      expected_classes = %w(govuk-button govuk-button--start)
      expect(rendered_content).to have_tag('a', text:, with: { class: expected_classes })
    end

    specify 'the link contains an SVG chevron' do
      expect(rendered_content).to have_tag('a') do
        with_tag('svg', with: { 'aria-hidden' => true }) { with_tag('path') }
        expect(html).to contain_svgs_with_viewBox_attributes
      end
    end

    specify 'the link has the right attributes' do
      expected_attributes = {
        'data-module' => 'govuk-button',
        'role' => 'button',
        'draggable' => 'false'
      }

      expect(rendered_content).to have_tag('a', with: expected_attributes)
    end

    it_behaves_like 'a component that accepts custom classes'
    it_behaves_like 'a component that accepts custom HTML attributes'
  end

  context 'as a button' do
    let(:as_button) { true }

    specify 'renders a button element with the right text and href' do
      expected_classes = %w(govuk-button govuk-button--start)
      expect(rendered_content).to have_tag('button', text:, with: { class: expected_classes })
    end

    specify 'the link contains an SVG chevron' do
      expect(rendered_content).to have_tag('button') do
        with_tag('svg', with: { 'aria-hidden' => true }) { with_tag('path') }
      end
    end

    specify 'the link has the right attributes' do
      expected_attributes = {
        'data-module' => 'govuk-button',
        'draggable' => 'false'
      }

      expect(rendered_content).to have_tag('button', with: expected_attributes)
    end

    it_behaves_like 'a component that accepts custom classes'
    it_behaves_like 'a component that accepts custom HTML attributes'
    it_behaves_like 'a component that supports custom branding'
  end
end
