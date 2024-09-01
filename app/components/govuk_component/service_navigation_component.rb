class GovukComponent::ServiceNavigationComponent < GovukComponent::Base
  renders_one :service_name, "GovukComponent::ServiceNavigationComponent::ServiceNameComponent"
  renders_many :navigation_items, ->(text:, href: nil, current_path: nil, active_when: nil, current: false, active: false, classes: [], html_attributes: {}) do
    GovukComponent::ServiceNavigationComponent::NavigationItemComponent.new(
      text:,
      href:,
      current_path:,
      active_when:,
      current:,
      active:,
      classes:,
      html_attributes:
    )
  end

  attr_reader :aria_label_text

  def initialize(service_name: nil, service_url: nil, navigation_items: [], current_path: nil, aria_label: "Service information", classes: [], html_attributes: {})
    @service_name_text = service_name
    @service_url = service_url
    @current_path = current_path
    @aria_label_text = aria_label

    if @service_name_text.present?
      with_service_name(service_name: @service_name_text, service_url:)
    end

    navigation_items.each { |ni| with_navigation_item(current_path:, **ni) }

    super(classes:, html_attributes:)
  end

  def call
    outer_element do
      tag.div(class: 'govuk-width_container') do
        tag.div(class: 'govuk-service-navigation__container') do
          safe_join([service_name, navigation].compact)
        end
      end
    end
  end

  def navigation
    return unless navigation_items?

    tag.nav(aria: { label: "Menu" }, class: 'govuk-service-navigation__wrapper') do
      safe_join([menu_button, navigation_list])
    end
  end

  def navigation_list
    tag.ul(safe_join(navigation_items), class: 'govuk-service-navigation__list')
  end

private

  def outer_element(&block)
    if service_name?
      tag.section(**aria_attributes, **html_attributes, &block)
    else
      tag.div(**html_attributes, &block)
    end
  end

  def default_attributes
    { class: 'govuk-service-navigation', data: { module: 'govuk-service-navigation' } }
  end

  def aria_attributes
    { aria: { label: aria_label_text } }
  end

  def menu_button
    tag.button(
      type: 'button',
      class: %w(govuk-service-navigation__toggle govuk-js-service-navigation-toggle),
      aria: { controls: 'navigation' },
      hidden: true
    )
  end
end
