class GovukComponent::TableComponent::CellComponent < GovukComponent::Base
  attr_reader :text, :header, :numeric, :width

  alias_method :numeric?, :numeric

  WIDTHS = {
    "full"           => "govuk-!-width-full",
    "three-quarters" => "govuk-!-width-three-quarters",
    "two-thirds"     => "govuk-!-width-two-thirds",
    "one-half"       => "govuk-!-width-one-half",
    "one-third"      => "govuk-!-width-one-third",
    "one-quarter"    => "govuk-!-width-one-quarter",
  }.freeze

  def initialize(header: false, text: nil, numeric: false, width: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @header  = header
    @text    = text
    @numeric = numeric
    @width   = width
  end

private

  def width?
    width.present?
  end

  def cell_content
    content || text
  end

  def cell_element
    header ? :th : :td
  end

  def default_classes
    if header
      class_names("govuk-table__header", "govuk-table__header--numeric" => numeric?, width_class => width?).split
    else
      class_names("govuk-table__cell", "govuk-table__cell--numeric" => numeric?, width_class => width?).split
    end
  end

  def width_class
    WIDTHS.fetch(width, nil)
  end
end
