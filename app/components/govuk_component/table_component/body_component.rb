class GovukComponent::TableComponent::BodyComponent < GovukComponent::Base
  renders_many :rows, ->(cell_data: nil, first_cell_is_header: false, classes: [], html_attributes: {}, &block) do
    GovukComponent::TableComponent::RowComponent.new(
      cell_data: cell_data,
      first_cell_is_header: first_cell_is_header,
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  def initialize(rows: nil, first_cell_is_header: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    build_rows_from_row_data(rows, first_cell_is_header)
  end

private

  def build_rows_from_row_data(data, first_cell_is_header)
    return if data.blank?

    data.each { |d| row(cell_data: d, first_cell_is_header: first_cell_is_header) }
  end

  def default_attributes
    { class: %w(govuk-table__body) }
  end
end
