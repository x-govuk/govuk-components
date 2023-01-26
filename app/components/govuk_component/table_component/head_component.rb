class GovukComponent::TableComponent::HeadComponent < GovukComponent::Base
  renders_many :rows, ->(cell_data: nil, classes: [], html_attributes: {}, &block) do
    GovukComponent::TableComponent::RowComponent.from_head(
      cell_data: cell_data,
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  attr_reader :row_data

  def initialize(rows: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    build_rows_from_row_data(rows)
  end

  def call
    tag.thead(**html_attributes) { safe_join(rows) }
  end

private

  def build_rows_from_row_data(data)
    return if data.blank?

    data.each { |d| with_row(cell_data: d) }
  end

  def default_attributes
    { class: %w(govuk-table__head) }
  end
end
