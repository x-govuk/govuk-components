class GovukComponent::TableComponent::CellComponent < GovukComponent::Base
  attr_reader :text, :header, :numeric

  alias_method :numeric?, :numeric

  def initialize(header: false, text: nil, numeric: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @header  = header
    @text    = text
    @numeric = numeric
  end

private

  def cell_content
    content || text
  end

  def cell_element
    header ? :th : :td
  end

  def default_classes
    if header
      %w(govuk-table__header).tap do |c|
        c << "govuk-table__header--numeric" if numeric?
      end
    else
      %w(govuk-table__cell).tap do |c|
        c << "govuk-table__cell--numeric" if numeric?
      end
    end
  end
end
