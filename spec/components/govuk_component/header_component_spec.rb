require 'spec_helper'

RSpec.describe(GovukComponent::HeaderComponent, type: :component, version: 2) do
  include_context "setup"
  include_context "helpers"

  let(:component_css_class) { 'govuk-header' }

  let(:logo) { 'OMG.UK' }
  let(:homepage_url) { 'https://omg.uk/bbq' }
  let(:service_name) { 'Amazing service 1' }
  let(:product_name) { 'Order an amazing ID' }
  let(:service_name_href) { 'https://omg.uk/bbq/amazing-service-1/home' }

  let(:all_kwargs) do
    {
      logo: logo,
      homepage_url: homepage_url,
      service_name: service_name,
      service_name_href: service_name_href,
      product_name: product_name,
    }
  end
  let(:kwargs) { all_kwargs }

  subject! { render_inline(GovukComponent::HeaderComponent.new(**kwargs)) }

  context 'by default' do
    let(:default_header_text) { 'GOV.UK' }
    let(:kwargs) { {} }

    specify 'outputs a header with correct logo text and no content' do
      expect(rendered_component).to have_tag('header', with: { class: component_css_class }) do
        with_tag('span', with: { class: 'govuk-header__logotype-text' }, text: default_header_text)
        without_tag('.govuk-header__content')
      end
    end
  end

  context 'customising the container classes' do
    let(:custom_classes) { %w(purple-zig-zags) }
    let(:kwargs) { { container_classes: custom_classes } }

    specify 'adds the custom classes to the header container' do
      expect(rendered_component).to have_tag('.govuk-header__container', with: { class: custom_classes })
    end
  end

  context 'when custom logo text and service name are provided' do
    let(:expected_service_name_classes) { %w(govuk-header__link govuk-header__link--service-name) }

    specify 'renders header with right logo text and provided service name' do
      expect(rendered_component).to have_tag('header', with: { class: component_css_class }) do
        with_tag('span', with: { class: 'govuk-header__logotype-text' }, text: logo)

        with_tag('div', class: 'govuk-header__content') do
          with_tag('a', text: service_name, with: { href: service_name_href, class: expected_service_name_classes })
        end
      end
    end
  end

  describe 'product name' do
    context 'when a product name is provided' do
      specify 'the product name should be present' do
        expect(rendered_component).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
          with_tag('a', with: { class: 'govuk-header__link' }) do
            with_tag('span', with: { class: 'govuk-header__product-name' }, text: product_name)
          end
        end
      end
    end

    context 'when no product name is provided' do
      let(:kwargs) { all_kwargs.except(:product_name) }

      specify "the product name container isn't rendered at all" do
        expect(rendered_component).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
          with_tag('a', with: { class: 'govuk-header__link' }) do
            without_tag('.govuk-header__product-name')
          end
        end
      end
    end

    describe 'product description' do
      let(:product_description_content) { "No seriously, it's amazing" }
      subject! do
        render_inline(GovukComponent::HeaderComponent.new(**kwargs)) do |component|
          component.product_description { product_description_content }
        end
      end

      specify 'when a product description block is provided' do
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-header__logo' }) do
          with_tag('a', with: { class: 'govuk-header__link' }, text: Regexp.new(product_description_content))
        end
      end
    end

    describe 'navigation menus' do
      context 'when no navigation items are supplied' do
        specify 'navigation block is not rendered' do
          expect(rendered_component).not_to have_tag('nav')
        end
      end

      context 'when navigation items are supplied' do
        let(:custom_classes) { %w(blue shiny) }
        let(:items) do
          [
            { title: 'Item 1', href: '/item-1' },
            { title: 'Item 2', href: '/item-2', active: true },
            { title: 'Item 3', href: '/item-3' }
          ]
        end

        specify 'nav element is rendered' do
          expect(rendered_component).to have_tag('nav')
        end

        specify 'nav contains the right number of items' do
          expect(rendered_component).to have_tag('nav') do
            with_tag('a', with: { class: 'govuk-header__link' }, count: items.size)
          end
        end

        specify 'custom classes provided via navigation_classes are present' do
          expect(rendered_component).to have_tag('ul', with: { class: custom_classes.append('govuk-header__navigation') })
        end

        specify 'nav items are rendered in the right structure' do
          expect(rendered_component).to have_tag('nav') do
            with_tag('ul', with: { class: 'govuk-header__navigation' }) do
              with_tag('li', with: { class: 'govuk-header__navigation-item' }) do
                with_tag('a', with: { class: 'govuk-header__link' })
              end
            end
          end
        end

        specify 'nav items have the right titles and links' do
          expect(rendered_component).to have_tag('nav') do
            items.each { |link| with_tag('a', with: { href: link.fetch(:href) }, text: link.fetch(:title)) }
          end
        end

        specify 'active nav item has active class' do
          active_link = items.detect { |item| item[:active] }

          expect(rendered_component).to have_tag('nav') do
            with_tag('li', text: active_link.fetch(:title), with: { class: 'govuk-header__navigation-item--active' }, count: 1)
          end
        end

        subject! do
          header_kwargs = kwargs.merge(navigation_classes: custom_classes)
          render_inline(GovukComponent::HeaderComponent.new(**header_kwargs)) do |component|
            items.each { |item| component.item(**item) }
          end
        end

        describe 'menu button (for mobile)' do
          let(:button_text) { 'Menu' }
          let(:button_classes) { %w(govuk-header__menu-button govuk-js-header-toggle) }
          let(:button_aria_label) { 'Show or hide navigation menu' }

          specify 'the button is rendered' do
            expect(rendered_component).to have_tag('div', with: { class: 'govuk-header__content' }) do
              with_tag('button', with: { class: button_classes, 'aria-label' => button_aria_label }, text: button_text)
            end
          end

          context 'when the menu button label is overriden' do
            let(:custom_label) { 'More stuff' }

            subject! do
              render_inline(GovukComponent::HeaderComponent.new(**kwargs.merge(menu_button_label: custom_label))) do |component|
                items.each { |item| component.item(**item) }
              end
            end

            specify 'the button is rendered with the provided aria-label' do
              expect(rendered_component).to have_tag('div', with: { class: 'govuk-header__content' }) do
                with_tag('button', with: { class: button_classes, 'aria-label' => custom_label }, text: button_text)
              end
            end
          end
        end

        context 'when the navigation label is overriden' do
          let(:custom_label) { 'Top level navigation' }

          subject! do
            render_inline(GovukComponent::HeaderComponent.new(**kwargs.merge(navigation_label: custom_label))) do |component|
              items.each { |item| component.item(**item) }
            end
          end

          specify 'the navigation label contains the custom text' do
            expect(rendered_component).to have_tag('ul', with: { class: 'govuk-header__navigation', 'aria-label' => custom_label })
          end
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :item }
    let(:content) { nil }
    let(:slot_kwargs) { { title: 'title', href: '/one/two/three', active: true } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end
end
