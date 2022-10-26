require 'spec_helper'

RSpec.describe(DsfrComponent::StartButtonComponent, type: :component) do
  let(:component_css_class) { 'fr-btn--start' }
  let(:text) { 'Department for Education' }
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:as_button) { false }
  let(:kwargs) { { text: text, href: href, as_button: as_button } }

  before do
    allow_any_instance_of(DsfrComponent::StartButtonComponent)
      .to(receive(:protect_against_forgery?).and_return(false))
  end

  subject! { render_inline(DsfrComponent::StartButtonComponent.new(**kwargs)) }

  context 'as a link' do
    specify 'renders a link element with the right text and href' do
      expected_classes = %w(fr-btn fr-btn--start)
      expect(rendered_content).to have_tag('a', text: text, with: { class: expected_classes })
    end

    specify 'the link contains an SVG chevron' do
      expect(rendered_content).to have_tag('a') do
        with_tag('svg', with: { 'aria-hidden' => true }) { with_tag('path') }
      end
    end

    specify 'the link has the right attributes' do
      expected_attributes = {
        'data-module' => 'fr-btn',
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
      expected_classes = %w(fr-btn fr-btn--start)
      expect(rendered_content).to have_tag('button', text: text, with: { class: expected_classes })
    end

    specify 'the link contains an SVG chevron' do
      expect(rendered_content).to have_tag('button') do
        with_tag('svg', with: { 'aria-hidden' => true }) { with_tag('path') }
      end
    end

    specify 'the link has the right attributes' do
      expected_attributes = {
        'data-module' => 'fr-btn',
        'draggable' => 'false'
      }

      expect(rendered_content).to have_tag('button', with: expected_attributes)
    end

    it_behaves_like 'a component that accepts custom classes'
    it_behaves_like 'a component that accepts custom HTML attributes'
  end
end
