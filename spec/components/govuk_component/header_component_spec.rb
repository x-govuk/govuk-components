require 'spec_helper'

RSpec.describe(GovukComponent::HeaderComponent, type: :component) do
  let(:component_css_class) { 'govuk-header' }
  let(:product_name) { 'Order an amazing ID' }
  let(:logotype) { 'OMG.UK' }
  let(:homepage_url) { 'https://omg.uk/bbq' }

  let(:all_kwargs) do
    { homepage_url:, }
  end
  let(:kwargs) { all_kwargs }

  subject! { render_inline(GovukComponent::HeaderComponent.new(**kwargs)) }

  context 'by default' do
    let(:default_header_text) { 'GOV.UK' }
    let(:kwargs) { {} }

    specify 'outputs a header with correct logo text and no content' do
      expect(rendered_content).to have_tag('header') do
        with_tag('div', with: { class: component_css_class }) do
          with_tag('svg', with: { class: 'govuk-header__logotype' })
          without_tag('.govuk-header__content')
        end
      end
    end

    specify 'contains a link with the homepage link class that defaults to https://www.gov.uk' do
      expect(rendered_content).to have_tag('a', text: 'GOV.UK', with: { class: 'govuk-header__homepage-link', href: 'https://www.gov.uk' })
    end

    specify "the header doesn't have a full width border" do
      expect(rendered_content).to have_tag('.govuk-header')
      expect(rendered_content).not_to have_tag('.govuk-header--full-width-border')
    end
  end

  context 'when full_width_border is true' do
    let(:kwargs) { { full_width_border: true } }

    specify 'adds the custom classes to the header container' do
      expect(rendered_content).to have_tag('div', with: { class: %w(govuk-header govuk-header--full-width-border) })
    end
  end

  context 'customising the container classes' do
    let(:custom_classes) { %w(purple-zig-zags) }
    let(:kwargs) { { container_classes: custom_classes } }

    specify 'adds the custom classes to the header container' do
      expect(rendered_content).to have_tag('.govuk-header__container', with: { class: custom_classes })
    end
  end

  context 'when the logo is overwritten' do
    let(:custom_logo_content) { "👑 Narnia" }
    let(:custom_logo) do
      helper.tag.h1(custom_logo_content)
    end

    subject! do
      render_inline(GovukComponent::HeaderComponent.new) do |component|
        component.with_custom_logo { custom_logo }
      end
    end

    specify "renders the custom logo" do
      expect(rendered_content).to have_tag("h1", text: custom_logo_content)
    end

    specify "doesn't render the crown" do
      expect(rendered_content).not_to have_tag("svg")
    end

    specify "doesn't render the default logotype" do
      expect(rendered_content).not_to have_tag("span", text: /GOV.UK/)
    end
  end

  describe 'product name' do
    context 'when a product name is provided with an argument' do
      let(:custom_name) { "The fantastic product" }

      subject! do
        render_inline(GovukComponent::HeaderComponent.new) do |component|
          component.with_product_name(name: custom_name)
        end
      end

      specify 'the product name should be present' do
        expect(rendered_content).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
          with_tag('a', with: { class: 'govuk-header__link' }) do
            with_tag('span', with: { class: 'govuk-header__product-name' }, text: custom_name)
          end
        end
      end
    end

    context 'when a product name is provided with a block' do
      let(:custom_name) { "The amazing product" }

      subject! do
        render_inline(GovukComponent::HeaderComponent.new) do |component|
          component.with_product_name { custom_name }
        end
      end

      specify 'the product name should be present' do
        expect(rendered_content).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
          with_tag('a', with: { class: 'govuk-header__link' }) do
            with_tag('div', with: { class: 'govuk-header__product-name' }, text: custom_name)
          end
        end
      end
    end

    context 'when no product name is provided' do
      let(:kwargs) { all_kwargs.except(:product_name) }

      specify "the product name container isn't rendered at all" do
        expect(rendered_content).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
          with_tag('a', with: { class: 'govuk-header__link' }) do
            without_tag('.govuk-header__product-name')
          end
        end
      end
    end
  end

  describe 'rendering service navigation within the header' do
    subject! do
      render_inline(GovukComponent::HeaderComponent.new(**kwargs)) do |header|
        header.with_service_navigation(service_name: "My new service", service_url: "#")
      end
    end

    specify "the service navigation component is rendered within the header element" do
      expect(rendered_content).to have_tag('header') do
        with_tag('section', with: { class: 'govuk-service-navigation' }) do
          with_tag('a', text: 'My new service', href: '#')
        end
      end
    end
  end

  describe 'rendering phase banner within the header' do
    subject! do
      render_inline(GovukComponent::HeaderComponent.new(**kwargs)) do |header|
        header.with_phase_banner(tag: { text: 'Alpha' }, text: 'This is a brand new service')
      end
    end

    specify 'the service navigation component is rendered within the header element' do
      expect(rendered_content).to have_tag('header') do
        with_tag('div', with: { class: 'govuk-phase-banner' }) do
          with_tag('strong', text: 'Alpha')
          with_text('This is a brand new service')
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'

  context 'slot arguments' do
    let(:slot) { :product_name }
    let(:content) { nil }
    let(:slot_kwargs) { { name: 'A product' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end
end
