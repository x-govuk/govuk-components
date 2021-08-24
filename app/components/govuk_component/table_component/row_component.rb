class GovukComponent::TableComponent::RowComponent < GovukComponent::Base
  renders_many :cells, GovukComponent::TableComponent::CellComponent

  attr_reader :header

  def initialize(cell_data: nil, header: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @header = header

    build_cells_from_cell_data(cell_data)
  end

private

  def build_cells_from_cell_data(cell_data)
    return if cell_data.blank?

    cell_data.map { |cd| cell(header: header, text: cd) }
  end

  def default_classes
    %w(govuk-table__row)
  end
end
