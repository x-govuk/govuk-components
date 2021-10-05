require 'spec_helper'

RSpec.describe(GovukComponent::HeaderComponent, type: :component) do
  before do
    allow_any_instance_of(GovukComponent::HeaderComponent::NavigationItem).to(
      receive(:request).and_return(double(ActionDispatch::Request, get?: true, path: current_page))
    )
  end

  let(:current_page) { "/item-3" }
  let(:component_css_class) { 'govuk-header' }

  let(:product_name) { 'Order an amazing ID' }

  let(:logotype) { 'OMG.UK' }
  let(:homepage_url) { 'https://omg.uk/bbq' }
  let(:service_name) { 'Amazing service 1' }
  let(:service_url) { 'https://omg.uk/bbq/amazing-service-1/home' }

  let(:all_kwargs) do
    {
      logotype: logotype,
      homepage_url: homepage_url,
      service_name: service_name,
      service_url: service_url
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

  describe 'the crown' do
    context 'when the crown is not disabled' do
      specify 'the crown SVG is rendered along with no fallback image' do
        expect(rendered_component).to have_tag('.govuk-header__logotype') do
          with_tag('svg', with: { class: 'govuk-header__logotype-crown' })
        end
      end

      context 'when a fallback image path is provided' do
        let(:custom_path) { '/an-alternative-crown-file.jpg' }
        let(:kwargs) { { crown_fallback_image: custom_path } }

        specify 'renders the fallback image with the custom path' do
          expect(rendered_component).to have_tag('.govuk-header__logotype') do
            with_tag('svg', with: { class: 'govuk-header__logotype-crown' }) do
              with_tag('image', with: { src: custom_path, class: 'govuk-header__logotype-crown-fallback-image' })
            end
          end
        end
      end
    end

    context 'when the crown is disabled' do
      let(:kwargs) { { crown: false } }

      specify "doesn't render the crown" do
        expect(rendered_component).not_to have_tag("svg")
      end

      specify "renders the default logotype" do
        expect(rendered_component).to have_tag("span", text: /GOV.UK/)
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

  context 'when custom logotype and service name are provided' do
    let(:expected_service_name_classes) { %w(govuk-header__link govuk-header__link--service-name) }

    specify 'renders header with right logotype and provided service name' do
      expect(rendered_component).to have_tag('header', with: { class: component_css_class }) do
        with_tag('span', with: { class: 'govuk-header__logotype-text' }, text: logotype)

        with_tag('div', class: 'govuk-header__content') do
          with_tag('a', text: service_name, with: { href: service_url, class: expected_service_name_classes })
        end
      end
    end
  end

  context 'when the logo is overwritten' do
    let(:custom_logo_content) { "👑 Narnia" }
    let(:custom_logo) do
      helper.tag.h1(custom_logo_content)
    end

    subject! do
      render_inline(GovukComponent::HeaderComponent.new) do |component|
        component.custom_logo { custom_logo }
      end
    end

    specify "renders the custom logo" do
      expect(rendered_component).to have_tag("h1", text: custom_logo_content)
    end

    specify "doesn't render the crown" do
      expect(rendered_component).not_to have_tag("svg")
    end

    specify "doesn't render the default logotype" do
      expect(rendered_component).not_to have_tag("span", text: /GOV.UK/)
    end
  end

  describe 'product name' do
    context 'when a product name is provided with an argument' do
      let(:custom_name) { "The fantastic product" }

      subject! do
        render_inline(GovukComponent::HeaderComponent.new) do |component|
          component.product_name(name: custom_name)
        end
      end

      specify 'the product name should be present' do
        expect(rendered_component).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
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
          component.product_name { custom_name }
        end
      end

      specify 'the product name should be present' do
        expect(rendered_component).to have_tag('div', with: { class: %w(govuk-header__logo) }) do
          with_tag('a', with: { class: 'govuk-header__link' }) do
            with_tag('div', with: { class: 'govuk-header__product-name' }, text: custom_name)
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
  end

  describe 'navigation menus' do
    context 'when no navigation items are supplied' do
      specify 'navigation block is not rendered' do
        expect(rendered_component).not_to have_tag('nav')
      end
    end

    context 'when navigation items are supplied' do
      let(:custom_classes) { %w(blue shiny) }
      let(:navigation_items) do
        [
          { text: 'Item 1', href: '/item-1' },
          { text: 'Item 2', href: '/item-2', active: true },
          { text: 'Item 3', href: '/item-3' },
          { text: 'Item 4', href: '/item-4', options: { method: :delete } }
        ]
      end

      subject! do
        header_kwargs = kwargs.merge(navigation_classes: custom_classes)
        render_inline(GovukComponent::HeaderComponent.new(**header_kwargs)) do |component|
          navigation_items.each { |navigation_item| component.navigation_item(**navigation_item) }
        end
      end

      specify 'nav element is rendered' do
        expect(rendered_component).to have_tag('nav')
      end

      specify 'nav contains the right number of items' do
        expect(rendered_component).to have_tag('nav') do
          with_tag('a', with: { class: 'govuk-header__link' }, count: navigation_items.size)
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

      specify 'nav items have the right text and links' do
        expect(rendered_component).to have_tag('nav') do
          navigation_items.each do |link|
            if link.key?(:options)
              with_tag('a', with: { href: link.fetch(:href), "data-method": link.dig(:options, :method) }, text: link.fetch(:text))
            else
              with_tag('a', with: { href: link.fetch(:href) }, text: link.fetch(:text))
            end
          end
        end
      end

      specify 'active nav item has active class' do
        active_link = navigation_items.detect { |item| item[:active] }

        expect(rendered_component).to have_tag('nav') do
          with_tag('li', with: { class: 'govuk-header__navigation-item--active' }) do
            with_tag('a', text: active_link.fetch(:text), count: 1)
          end
        end
      end

      specify 'nav item on current page has active class' do
        active_link = navigation_items.detect { |item| item[:href] == current_page }

        expect(rendered_component).to have_tag('nav') do
          with_tag('li', with: { class: 'govuk-header__navigation-item--active' }) do
            with_tag('a', text: active_link.fetch(:text), count: 1)
          end
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
              navigation_items.each { |item| component.navigation_item(**item) }
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
            navigation_items.each { |item| component.navigation_item(**item) }
          end
        end

        specify 'the navigation label contains the custom text' do
          expect(rendered_component).to have_tag('ul', with: { class: 'govuk-header__navigation', 'aria-label' => custom_label })
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :navigation_item }
    let(:content) { nil }
    let(:slot_kwargs) { { text: 'text', href: '/one/two/three', active: true } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end
end
