class GovukComponent::TableComponent::FootComponent < GovukComponent::Base
  renders_many :rows, ->(cell_data: nil, first_cell_is_header: false, classes: [], html_attributes: {}, &block) do
    GovukComponent::TableComponent::RowComponent.from_foot(
      cell_data: cell_data,
      first_cell_is_header: first_cell_is_header,
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  attr_reader :first_cell_is_header, :row_data

  def initialize(rows: nil, first_cell_is_header: false, classes: [], html_attributes: {})
    @rows = rows
    @first_cell_is_header = first_cell_is_header

    super(classes: classes, html_attributes: html_attributes)

    return unless rows.presence

    build_rows_from_row_data(rows)
  end

  def call
    tag.tfoot(**html_attributes) { safe_join(rows) }
  end

  def render?
    rows.any?
  end

private

  def build_rows_from_row_data(data)
    return if data.blank?

    with_row(cell_data: data, first_cell_is_header: first_cell_is_header)
  end

  def default_attributes
    { class: "#{brand}-table__foot" }
  end
end
