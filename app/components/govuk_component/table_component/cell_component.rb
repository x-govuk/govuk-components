class GovukComponent::TableComponent::CellComponent < GovukComponent::Base
  attr_reader :text, :header, :numeric, :width, :scope, :parent, :colspan, :rowspan

  alias_method :numeric?, :numeric
  alias_method :header?, :header

  WIDTHS = {
    "full"           => "#{ brand }-!-width-full",
    "three-quarters" => "#{ brand }-!-width-three-quarters",
    "two-thirds"     => "#{ brand }-!-width-two-thirds",
    "one-half"       => "#{ brand }-!-width-one-half",
    "one-third"      => "#{ brand }-!-width-one-third",
    "one-quarter"    => "#{ brand }-!-width-one-quarter",
  }.freeze

  def initialize(scope: nil, header: nil, numeric: false, text: nil, width: nil, parent: nil, rowspan: nil, colspan: nil, classes: [], html_attributes: {})
    @text    = text
    @numeric = numeric
    @width   = width
    @scope   = scope
    @parent  = parent
    @colspan = colspan
    @rowspan = rowspan
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
    if in_thead? || header?
      'th'
    else
      'td'
    end
  end

  def default_attributes
    { class: default_classes, scope: determine_scope, colspan: colspan, rowspan: rowspan }.compact
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
    in { auto_table_scopes: true, parent: 'tbody' } | { auto_table_scopes: true, parent: 'tfoot' }
      'row'
    else
      nil
    end
  end

  def default_classes
    class_names(
      "#{ brand }-table__#{class_suffix}",
      "#{ brand }-table__#{class_suffix}--numeric" => numeric?,
      width => width?,
    )
  end

  def class_suffix
    if in_thead? || (in_tbody? && header?)
      "header"
    elsif in_tfoot?
      "footer"
    else
      "cell"
    end
  end

  def in_thead?
    parent == "thead"
  end

  def in_tfoot?
    parent == "tfoot"
  end

  def in_tbody?
    parent == "tbody"
  end
end
