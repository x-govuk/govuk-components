class GovukComponent::ServiceNavigationComponent::NavigationItemComponent < GovukComponent::Base
  attr_reader :text, :href, :current_path, :active_when, :current, :active

  def initialize(text:, href: nil, current_path: nil, active_when: nil, current: false, active: false, classes: [], html_attributes: {})
    @current = current
    @active = active
    @text = text
    @href = href

    @current_path = current_path
    @active_when = active_when

    super(classes:, html_attributes:)
  end

  def call
    tag.li(**html_attributes) do
      if href.present?
        wrap_link(link_to(text, href, class: 'govuk-service-navigation__link', **aria_current))
      else
        tag.span(text, class: 'govuk-service-navigation__text')
      end
    end
  end

private

  def wrap_link(link)
    if current_or_active?
      tag.strong(link, class: 'govuk-service-navigation__active-fallback')
    else
      link
    end
  end

  def current?
    current || auto_current?
  end

  def active?
    active || auto_active?
  end

  def current_or_active?
    current? || active?
  end

  def auto_current?
    return if current_path.blank?

    current_path == href
  end

  def auto_active?
    return if current_path.blank?

    case active_when
    when Regexp
      active_when.match?(current_path)
    when String
      current_path.start_with?(active_when)
    when Array
      active_when.any? { |p| current_path.start_with?(p) }
    else
      false
    end
  end

  def default_attributes
    {
      class: class_names(
        'govuk-service-navigation__item',
        'govuk-service-navigation__item--active' => current_or_active?
      )
    }
  end

  def aria_current
    current = (current?) ? 'page' : true

    { aria: { current: } }
  end
end
