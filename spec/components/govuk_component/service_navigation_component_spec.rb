require 'spec_helper'

RSpec.describe(GovukComponent::ServiceNavigationComponent, type: :component) do
  let(:component_css_class) { 'govuk-service-navigation' }

  let(:service_name) { nil }
  let(:service_url) { nil }
  let(:navigation_items) { [] }
  let(:current_path) { nil }
  let(:navigation_id) { nil }
  let(:inverse) { false }
  let(:kwargs) { { service_name:, service_url:, navigation_items:, current_path:, navigation_id:, inverse: }.compact }

  subject! { render_inline(GovukComponent::ServiceNavigationComponent.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'

  specify 'renders a div with the expected attributes' do
    expect(rendered_content).to have_tag("div", with: { class: component_css_class, 'data-module' => 'govuk-service-navigation' })
  end

  context 'when a service name is present' do
    let(:service_name) { "My new service" }

    specify 'the outer element is a section with an aria label attribute' do
      expect(rendered_content).to have_tag("section", with: {
        class: component_css_class,
        'data-module' => 'govuk-service-navigation',
        'aria-label' => 'Service information'
      })
    end

    specify 'contains the service name in a span' do
      expect(rendered_content).to have_tag("section", with: { class: component_css_class }) do
        with_tag('div', with: { class: 'govuk-width-container' }) do
          with_tag('div', with: { class: 'govuk-service-navigation__container' }) do
            with_tag('span', class: 'govuk-service-navigation__service-name') do
              with_tag('span', text: service_name, with: { class: 'govuk-service-navigation__text' })
            end
          end
        end
      end
    end

    context 'when a service_url is present' do
      let(:service_url) { "https://my-new.service.gov.uk" }

      specify 'contains a hyperlink with the service name and url' do
        expect(rendered_content).to have_tag("section", with: { class: component_css_class }) do
          with_tag('div', with: { class: 'govuk-width-container' }) do
            with_tag('div', with: { class: 'govuk-service-navigation__container' }) do
              with_tag('span', class: 'govuk-service-navigation__service-name') do
                with_tag('a', text: service_name, with: { href: service_url, class: 'govuk-service-navigation__link' })
              end
            end
          end
        end
      end
    end
  end

  context 'when navigation items are supplied as an argument' do
    let(:navigation_items) do
      [
        { text: 'Item one', href: '/item-one' },
        { text: 'Item two', href: '/item-two' },
      ]
    end

    specify 'the items are rendered in a list' do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class }) do
        with_tag('div', with: { class: 'govuk-width-container' }) do
          with_tag('div', with: { class: 'govuk-service-navigation__container' }) do
            with_tag('ul', with: { class: 'govuk-service-navigation__list' }) do
              navigation_items.each do |ni|
                with_tag('li', with: { class: 'govuk-service-navigation__item' }) do
                  with_tag('a', text: ni.fetch(:text), with: { href: ni.fetch(:href) })
                end
              end
            end
          end
        end
      end
    end

    specify %(the list and button are correctly cross-referenced with 'navigation' by default) do
      expect(rendered_content).to have_tag('ul', with: { id: 'navigation' })
      expect(rendered_content).to have_tag('button', with: { 'aria-controls' => 'navigation' })
    end

    context 'when the navigation_id is overridden' do
      let(:navigation_id) { 'another-example' }

      specify %(the list and button are correctly cross-referenced with 'navigation' by default) do
        expect(rendered_content).to have_tag('ul', with: { id: navigation_id })
        expect(rendered_content).to have_tag('button', with: { 'aria-controls' => navigation_id })
      end
    end

    specify 'the menu button is present' do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class }) do
        with_tag('div', with: { class: 'govuk-width-container' }) do
          with_tag('div', with: { class: 'govuk-service-navigation__container' }) do
            with_tag('button', with: {
              type: 'button',
              class: %w(govuk-service-navigation__toggle govuk-js-service-navigation-toggle),
              hidden: 'hidden',
              'aria-controls' => 'navigation'
            })
          end
        end
      end
    end

    context 'when one of the navigation items is current' do
      let(:navigation_items) do
        [
          { text: 'Item one', href: '/item-one' },
          { text: 'Item two', href: '/item-two', current: true },
        ]
      end

      specify 'only the current link is wrapped in a strong element' do
        expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
          with_tag('a', text: 'Item one', with: { href: '/item-one' })

          with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }) do
            with_tag('a', text: 'Item two', with: { href: '/item-two' })
          end
        end
      end

      specify %(the current link has aria-current='page') do
        expect(rendered_content).to have_tag('a', text: 'Item two', with: { href: '/item-two', 'aria-current' => 'page' })
      end
    end

    describe 'matching the current page' do
      context 'when one of the navigation items matches the current_path' do
        let(:current_path) { '/admin' }
        let(:navigation_items) do
          [
            { text: 'Admin', href: '/admin' },
            { text: 'Finance', href: '/finance' },
          ]
        end

        specify 'only the matching page is wrapped in a strong element' do
          expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
            with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }, count: 1) do
              with_tag('a', text: 'Admin', with: { href: '/admin' })
            end
          end
        end
      end
    end

    context 'when one of the navigation items is active' do
      let(:navigation_items) do
        [
          { text: 'Item one', href: '/item-one' },
          { text: 'Item two', href: '/item-two', active: true },
        ]
      end

      specify 'only the active link is wrapped in a strong element' do
        expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
          with_tag('a', text: 'Item one', with: { href: '/item-one' })

          with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }) do
            with_tag('a', text: 'Item two', with: { href: '/item-two' })
          end
        end
      end

      specify %(the active link has aria-current='true') do
        expect(rendered_content).to have_tag('a', text: 'Item two', with: { href: '/item-two', 'aria-current' => 'true' })
      end
    end

    context 'when active_when is set with a string' do
      let(:current_path) { '/admin/users/1' }
      let(:navigation_items) do
        [
          { text: 'Admin', href: '/admin', active_when: '/admin' },
          { text: 'Finance', href: '/finance' },
        ]
      end

      specify 'only the active link is wrapped in a strong element' do
        expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
          with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }, count: 1) do
            with_tag('a', text: 'Admin', with: { href: '/admin' })
          end
        end
      end

      specify %(the active link has aria-current='true') do
        expect(rendered_content).to have_tag('a', text: 'Admin', with: { href: '/admin', 'aria-current' => 'true' })
      end
    end

    context 'when active_when is set with an array' do
      let(:current_path) { '/fr/ventes' }
      let(:navigation_items) do
        [
          { text: 'Admin', href: '/admin' },
          { text: 'Sales', href: '/sales', active_when: ['/finance', '/fr/ventes'] },
        ]
      end

      specify 'only the active link is wrapped in a strong element' do
        expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
          with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }, count: 1) do
            with_tag('a', text: 'Sales', with: { href: '/sales' })
          end
        end
      end

      specify %(the active link has aria-current='true') do
        expect(rendered_content).to have_tag('a', text: 'Sales', with: { href: '/sales', 'aria-current' => 'true' })
      end
    end

    context 'when active_when is set with a regular expression' do
      let(:current_path) { '/treasure/booty' }
      let(:navigation_items) do
        [
          { text: 'Admin', href: '/admin', active_when: '/admin' },
          { text: 'Finance', href: '/finance', active_when: %r{^/finance|^/treasure} },
        ]
      end

      specify 'only the active link is wrapped in a strong element' do
        expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
          with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }, count: 1) do
            with_tag('a', text: 'Finance', with: { href: '/finance' })
          end
        end
      end

      specify %(the active link has aria-current='true') do
        expect(rendered_content).to have_tag('a', text: 'Finance', with: { href: '/finance', 'aria-current' => 'true' })
      end
    end
  end

  describe 'inverting the colours' do
    let(:inverse_class) { 'govuk-service-navigation--inverse' }
    let(:inverse_class_selector) { '.' + inverse_class }

    context 'when inverse is not set' do
      let(:inverse) { nil }

      it 'renders the component without the inverse class' do
        expect(rendered_content).not_to have_tag(inverse_class_selector)
      end
    end

    context 'when inverse is false' do
      let(:inverse) { false }

      it 'renders the component without the inverse class' do
        expect(rendered_content).not_to have_tag(inverse_class_selector)
      end
    end

    context 'when inverse is true' do
      let(:inverse) { true }

      it 'renders the component with the inverse class' do
        expect(rendered_content).to have_tag("div", with: { class: [component_css_class, inverse_class], 'data-module' => 'govuk-service-navigation' })
      end
    end

    context 'when a service name is present and inverse is true' do
      let(:service_name) { 'A very nice service' }
      let(:inverse) { true }

      it 'renders the component with the inverse class' do
        expect(rendered_content).to have_tag("section", with: { class: [component_css_class, inverse_class], 'data-module' => 'govuk-service-navigation' })
      end
    end
  end

  context 'building the component manually' do
    let(:kwargs) { {} }
    subject! do
      render_inline(GovukComponent::ServiceNavigationComponent.new) do |sn|
        sn.with_service_name(service_name: 'A nice service')
        sn.with_navigation_item(text: 'Page 1', href: '/page-1')
        sn.with_navigation_item(text: 'Page 2', href: '/page-2', current: true)
        sn.with_navigation_item(text: 'Page 3', href: '/page-3')
      end
    end

    specify 'renders a section with the expected attributes' do
      expect(rendered_content).to have_tag("section", with: { class: component_css_class, 'data-module' => 'govuk-service-navigation' })
    end

    specify 'renders the navigation items' do
      1.upto(3) do |i|
        expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
          with_tag('a', text: "Page #{i}", with: { href: "/page-#{i}" })
        end
      end
    end

    specify %(marks the page with 'current: true' properly) do
      expect(rendered_content).to have_tag('li', with: { class: 'govuk-service-navigation__item' }) do
        with_tag('strong', with: { class: 'govuk-service-navigation__active-fallback' }) do
          with_tag('a', text: "Page 2", with: { href: "/page-2" })
        end
      end
    end
  end
end

RSpec.describe(GovukComponent::ServiceNavigationComponent::ServiceNameComponent, type: :component) do
  let(:component_css_class) { 'govuk-service-navigation__service-name' }
  let(:kwargs) { { service_name: "A service", service_url: "https://a-service.service.gov.uk" } }

  subject! { render_inline(GovukComponent::ServiceNavigationComponent::ServiceNameComponent.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
end

RSpec.describe(GovukComponent::ServiceNavigationComponent::NavigationItemComponent, type: :component) do
  let(:component_css_class) { 'govuk-service-navigation__item' }
  let(:kwargs) { { text: "A node", href: "/a-node" } }

  subject! { render_inline(GovukComponent::ServiceNavigationComponent::NavigationItemComponent.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
end
