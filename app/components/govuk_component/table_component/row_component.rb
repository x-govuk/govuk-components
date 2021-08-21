class GovukComponent::TableComponent::RowComponent < GovukComponent::Base
  renders_many :cells
  renders_many :header_cells # th

  attr_reader :cell_data, :header

  def initialize(cell_data: nil, header: false)
    @cell_data = cell_data
    @header = header
  end

  def call
    tag.tr(class: classes) { row_content }
  end

private

  def row_content
    cells || header_cells || if header
                               build_header_cells
                             else
                               build_cells
                             end
  end

  def build_cells
    cell_data.each { |cell| cell(text: cell) }
  end

  def build_header_cells
    cell_data.each { |cell| header_cell(text: cell) }
  end

  def default_classes
    %w(govuk-table__row)
  end
end
