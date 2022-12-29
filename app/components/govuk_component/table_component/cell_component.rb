class GovukComponent::TableComponent::CellComponent < GovukComponent::Base
  attr_reader :text, :header, :numeric, :width, :scope, :parent

  alias_method :numeric?, :numeric
  alias_method :header?, :header

  WIDTHS = {
    "full"           => "govuk-!-width-full",
    "three-quarters" => "govuk-!-width-three-quarters",
    "two-thirds"     => "govuk-!-width-two-thirds",
    "one-half"       => "govuk-!-width-one-half",
    "one-third"      => "govuk-!-width-one-third",
    "one-quarter"    => "govuk-!-width-one-quarter",
  }.freeze

  def initialize(scope: nil, header: false, numeric: false, text: nil, width: nil, parent: nil, classes: [], html_attributes: {})
    @header  = header
    @text    = text
    @numeric = numeric
    @width   = width
    @scope   = scope
    @parent  = parent

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
    { class: default_classes, scope: (scope || default_scope) }
  end

  def default_scope
    return unless header?
    return 'col' if parent == 'thead'
    return 'row' if parent == 'tbody'

    # FIXME: tfoot? https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tfoot

    fail(ArgumentError, "invalid parent")
  end

  def default_classes
    if header
      class_names("govuk-table__header", "govuk-table__header--numeric" => numeric?, width_class => width?)
    else
      class_names("govuk-table__cell", "govuk-table__cell--numeric" => numeric?, width_class => width?)
    end
  end

  def width_class
    WIDTHS.fetch(width, nil)
  end
end
