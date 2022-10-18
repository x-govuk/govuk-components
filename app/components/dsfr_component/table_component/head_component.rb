class DsfrComponent::TableComponent::HeadComponent < DsfrComponent::Base
  renders_many :rows, "DsfrComponent::TableComponent::RowComponent"

  attr_reader :row_data

  def initialize(rows: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    build_rows_from_row_data(rows)
  end

private

  def build_rows_from_row_data(data)
    return if data.blank?

    data.each { |d| row(cell_data: d, header: true) }
  end

  def default_attributes
    { class: %w(govuk-table__head) }
  end
end
