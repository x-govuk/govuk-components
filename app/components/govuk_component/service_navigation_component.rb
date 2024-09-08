class GovukComponent::ServiceNavigationComponent < GovukComponent::Base
  renders_one :start_slot
  renders_one :end_slot

  renders_one :service_name, "GovukComponent::ServiceNavigationComponent::ServiceNameComponent"
  renders_many :navigation_items, ->(text:, href: nil, current_path: nil, active_when: nil, current: false, active: false, classes: [], html_attributes: {}) do
    GovukComponent::ServiceNavigationComponent::NavigationItemComponent.new(
      text:,
      href:,
      current_path: current_path || @current_path,
      active_when:,
      current:,
      active:,
      classes:,
      html_attributes:
    )
  end

  attr_reader :aria_label_text, :navigation_id

  def initialize(service_name: nil, service_url: nil, navigation_items: [], current_path: nil, aria_label: "Service information", navigation_id: 'navigation', classes: [], html_attributes: {})
    @service_name_text = service_name
    @service_url = service_url
    @current_path = current_path
    @aria_label_text = aria_label
    @navigation_id = navigation_id

    if @service_name_text.present?
      with_service_name(service_name: @service_name_text, service_url:)
    end

    navigation_items.each { |ni| with_navigation_item(current_path:, **ni) }

    super(classes:, html_attributes:)
  end

  def call
    outer_element do
      tag.div(class: "#{brand}-width-container") do
        safe_join(
          [
            start_slot,
            tag.div(class: "#{brand}-service-navigation__container") do
              safe_join([service_name, navigation].compact)
            end,
            end_slot
          ]
        )
      end
    end
  end

  def navigation
    return unless navigation_items?

    tag.nav(aria: { label: "Menu" }, class: "#{brand}-service-navigation__wrapper") do
      safe_join([menu_button, navigation_list])
    end
  end

  def navigation_list
    tag.ul(safe_join(navigation_items), id: navigation_id, class: "#{brand}-service-navigation__list")
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
    { class: "#{brand}-service-navigation", data: { module: "#{brand}-service-navigation" } }
  end

  def aria_attributes
    { aria: { label: aria_label_text } }
  end

  def menu_button
    tag.button(
      "Menu",
      type: 'button',
      class: ["#{brand}-service-navigation__toggle", "#{brand}-js-service-navigation-toggle"],
      aria: { controls: navigation_id },
      hidden: true
    )
  end
end
