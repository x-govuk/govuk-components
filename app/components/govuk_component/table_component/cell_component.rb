class GovukComponent::TableComponent::CellComponent < GovukComponent::Base
  attr_reader :text, :header

  def initialize(header: false, text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @header = header
    @text   = text
  end

private

  def cell_content
    content || text
  end

  def cell_element
    header ? :th : :td
  end

  def default_classes
    header ? %w(govuk-table__header) : %w(govuk-table__cell)
  end
end
