class GovukComponent::TableComponent::BodyComponent < GovukComponent::Base
  renders_many :rows, GovukComponent::TableComponent::RowComponent

  attr_reader :row_data

  def initialize(rows: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @row_data = rows
  end

  def call
    tag.tbody(class: classes) { body_content }
  end

private

  def body_content
    rows.presence || build_rows
  end

  def build_rows
    safe_join(row_data.map { |rd| row(cell_data: rd) })
  end

  def default_classes
    %w(govuk-table__body)
  end
end
