class GovukComponent::Layout::Column < GovukComponent::Base
  WIDTHS = {
    'full'           => 'govuk-grid-column-full',
    'one-half'       => 'govuk-grid-column-one-half',
    'two-thirds'     => 'govuk-grid-column-two-thirds',
    'one-third'      => 'govuk-grid-column-one-third',
    'three-quarters' => 'govuk-grid-column-three-quarters',
    'one-quarter'    => 'govuk-grid-column-one-quarter',
  }.freeze

  def initialize(width:, from_desktop: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @width        = width
    @from_desktop = from_desktop
  end

  def call
    tag.div(class: classes.push(width_class, from_desktop_class), **html_attributes) { content }
  end

private

  def width_class
    retrieve_width_class(@width)
  end

  def from_desktop_class
    return unless @from_desktop.present?

    retrieve_width_class(@from_desktop) + '-from-desktop'
  end

  def retrieve_width_class(width)
    WIDTHS.fetch(width)
  rescue KeyError
    fail ArgumentError, %(invalid width: #{width}, valid widths are #{WIDTHS.keys.join(",")})
  end
end
