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

  def initialize(scope: nil, header: nil, numeric: false, text: nil, width: nil, parent: nil, classes: [], html_attributes: {})
    @text    = text
    @numeric = numeric
    @width   = width
    @scope   = scope
    @parent  = parent
    @header  = (header.nil?) ? in_thead? : header

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
    { class: default_classes, scope: determine_scope }
  end

  def determine_scope
    conditions = { scope: scope, parent: parent, header: header, auto_table_scopes: config.enable_auto_table_scopes }

    case conditions
    in { scope: String }
      scope
    in { scope: false } | { header: false } | { auto_table_scopes: false }
      nil
    in { auto_table_scopes: true, parent: 'thead' }
      'col'
    in { auto_table_scopes: true, parent: 'tbody' }
      'row'
    else
      Rails.logger.warn("No scope pattern matched")

      nil
    end
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

  def in_thead?
    parent == "thead"
  end
end
