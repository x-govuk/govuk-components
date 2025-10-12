class GovukComponent::PaginationComponent::Item < GovukComponent::Base
  attr_reader :number, :href, :visually_hidden_text, :mode

  def initialize(number: nil, href: nil, current: false, ellipsis: false, from_pagy: false, visually_hidden_text: nil, classes: [], html_attributes: {})
    @number               = number
    @href                 = href
    @visually_hidden_text = visually_hidden_text

    # We have three modes for rendering links:
    #
    #  * link    (a link to another page)
    #  * current (a link to the current page)
    #  * gap     (an ellipsis symbol)
    #
    # Pagy sets these by object type:
    # Integer = link
    # String  = current
    # :gap    = gap
    #
    # The original Nunjucks component has two boolean settings instead,
    # ellipsis and current. When ellipsis is true all other arguments are
    # ignored
    @mode = from_pagy ? pagy_mode(number) : manual_mode(ellipsis, current)

    super(classes:, html_attributes:)
  end

  def call
    case mode
    when :link
      link(current: false)
    when :current
      link(current: true)
    when :gap
      ellipsis_item
    end
  end

private

  def pagy_mode(number)
    return :link    if number.is_a?(Integer)
    return :current if number.is_a?(String)

    :gap
  end

  def manual_mode(ellipsis, current)
    return :gap     if ellipsis
    return :current if current

    :link
  end

  def link(current: false)
    attributes = html_attributes.tap { |ha| ha[:class] << "#{brand}-pagination__item--current" if current }

    tag.li(**attributes) do
      tag.a(href:, class: ["#{brand}-link", "#{brand}-pagination__link"]) { number.to_s }
    end
  end

  def ellipsis_item
    tag.li("⋯", class: ["#{brand}-pagination__item", "#{brand}-pagination__item--ellipsis"])
  end

  def default_attributes
    {
      class: ["#{brand}-pagination__item"],
      aria: { label: aria_label }
    }
  end

  def aria_label
    visually_hidden_text || "Page #{number}"
  end
end
