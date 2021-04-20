require 'spec_helper'

RSpec.describe(GovukComponent::Header, type: :component) do
  include_context "helpers"

  let(:logo) { 'OMG.UK' }
  let(:logo_href) { 'https://omg.uk/bbq' }
  let(:service_name) { 'Amazing service 1' }
  let(:product_name) { 'Order an amazing ID' }
  let(:service_name_href) { 'https://omg.uk/bbq/amazing-service-1/home' }
  let(:kwargs) do
    {
      logo: logo,
      logo_href: logo_href,
      service_name: service_name,
      service_name_href: service_name_href,
      product_name: product_name,
    }
  end

  let(:component) { GovukComponent::Header.new(**kwargs) }
  subject! { render_inline(component) }

  context 'when only the logo and service are specified' do
    specify 'outputs a header with correct logo and service name' do
      expect(page).to have_css('.govuk-header') do |header|
        expect(header).to have_css('span', class: 'govuk-header__logotype-text', text: logo)
        expect(header).to have_css('.govuk-header__content') do |content|
          expect(content).to have_link(service_name, href: service_name_href, class: %w(govuk-header__link govuk-header__link--service-name))
        end
      end
    end

    context 'when no service name is present' do
      let(:component) { GovukComponent::Header.new(**kwargs.except(:service_name)) }

      specify 'no service name related markup should be present' do
        expect(page).not_to have_css('.govuk-header__link--service-name')
      end
    end
  end

  describe 'product name' do
    context 'when a product name is provided' do
      specify "the product name should be present" do
        expect(page).to have_css('.govuk-header__product-name', text: product_name)
      end
    end

    context 'when no product name is provided' do
      let(:component) { GovukComponent::Header.new(**kwargs.except(:product_name)) }

      specify 'no product name container should be rendered' do
        expect(page).to have_css('.govuk-header__logo .govuk-header__link') do |link|
          expect(link).not_to have_css('.govuk-header__product-name')
        end
      end
    end
  end

  describe 'product description' do
    let(:product_description_content) { "No seriously, it's amazing" }
    subject! do
      render_inline(GovukComponent::Header.new(**kwargs)) do |component|
        component.slot(:product_description) { product_description_content }
      end
    end

    specify 'when a product description block is provided' do
      expect(page).to have_css('.govuk-header__logo') do |logo|
        expect(logo).to have_css('.govuk-header__link', text: Regexp.new(product_description_content))
      end
    end
  end

  describe 'navigation menus' do
    context 'when no navigation items are supplied' do
      specify 'the navigation block should not be present in the output' do
        expect(page).not_to have_css('nav')
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

      subject! do
        render_inline(GovukComponent::Header.new(**kwargs.merge(navigation_classes: custom_classes))) do |component|
          items.each { |item| component.slot(:item, **item) }
        end
      end

      specify 'a button to expand the menu on mobile is added' do
        expect(page).to have_css('.govuk-header__content button.govuk-header__menu-button', text: 'Menu')
      end

      context 'when the button label is overriden' do
        let(:custom_label) { 'More stuff' }

        subject! do
          render_inline(GovukComponent::Header.new(**kwargs.merge(menu_button_label: custom_label))) do |component|
            items.each { |item| component.slot(:item, **item) }
          end
        end

        specify 'the button contains the custom text' do
          expect(page).to have_css('.govuk-header__content button.govuk-header__menu-button', text: custom_label)
        end
      end

      specify 'the navigation block should be present in the output' do
        expect(page).to have_css('nav')
      end

      specify 'the correct number of navigation items should be present' do
        page.find('nav') do |nav|
          expect(nav).to have_css('.govuk-header__link', count: items.size)
        end
      end

      specify 'the class names in navigation_classes should be applied' do
        expect(page).to have_css(%(.govuk-header__navigation.#{custom_classes.join('.')}))
      end

      specify 'the navigation menu markup should be correct' do
        structure = %w(nav ul.govuk-header__navigation li.govuk-header__navigation-item a.govuk-header__link)

        expect(page).to have_css(structure.join(' > '), count: items.size)
      end

      specify 'the item titles and hrefs should be correct' do
        page.find('nav') do |nav|
          items.each { |link| expect(nav).to have_link(link[:title], href: link[:href]) }
        end
      end

      specify 'the link with active: true should have the active class' do
        active_link = items.detect { |item| item[:active] }

        page.find('nav') do |nav|
          expect(nav).to have_css('li', text: active_link[:title], class: 'govuk-header__navigation-item--active', count: 1)
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

  it_behaves_like 'a component with a DSL wrapper' do
    let(:helper_name) { 'govuk_header' }
    let(:wrapped_slots) { %i(item) }
    let(:block) { nil }

    let(:expected_css) { '.govuk-header' }
  end
end
