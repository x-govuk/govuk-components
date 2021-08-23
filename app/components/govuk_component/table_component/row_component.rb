class GovukComponent::TableComponent::RowComponent < GovukComponent::Base
  renders_many :cells, GovukComponent::TableComponent::CellComponent
  renders_many :header_cells, GovukComponent::TableComponent::HeaderComponent

  attr_reader :cell_data, :header

  def initialize(cell_data: nil, header: false)
    @cell_data = cell_data
    @header    = header
  end

  def call
    tag.tr(class: classes) { row_content }
  end

private

  def row_content
    cells.presence || header_cells.presence || if header
                                                 build_header_cells
                                               else
                                                 build_cells
                                               end
  end

  def build_cells
    safe_join(cell_data.map { |cell| cell(text: cell) })
  end

  def build_header_cells
    safe_join(cell_data.map { |cell| header_cell(text: cell) })
  end

  def default_classes
    %w(govuk-table__row)
  end
end
