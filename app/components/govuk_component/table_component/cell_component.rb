class GovukComponent::TableComponent::CellComponent < GovukComponent::Base
  attr_reader :text, :header, :numeric, :width, :scope

  alias_method :numeric?, :numeric

  WIDTHS = {
    "full"           => "govuk-!-width-full",
    "three-quarters" => "govuk-!-width-three-quarters",
    "two-thirds"     => "govuk-!-width-two-thirds",
    "one-half"       => "govuk-!-width-one-half",
    "one-third"      => "govuk-!-width-one-third",
    "one-quarter"    => "govuk-!-width-one-quarter",
  }.freeze

  def initialize(scope:, header: false, numeric: false, text: nil, width: nil, classes: [], html_attributes: {})
    @header  = header
    @text    = text
    @numeric = numeric
    @width   = width
    @scope   = scope

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    content_tag(cell_element, cell_content, **html_attributes)
  end

private

  def width?
    width.present?
  end

  def cell_content
    content || text
  end

  def cell_element
    header ? 'th' : 'td'
  end

  def default_attributes
    {
      class: default_classes,
      scope: scope
    }
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
