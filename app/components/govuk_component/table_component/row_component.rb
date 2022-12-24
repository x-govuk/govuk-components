class GovukComponent::TableComponent::RowComponent < GovukComponent::Base
  renders_many :cells, ->(header: false, scope: nil, text: nil, numeric: false, width: nil, classes: [], html_attributes: {}, &block) do
    GovukComponent::TableComponent::CellComponent.new(
      header: header,
      text: text,
      numeric: numeric,
      width: width,
      scope: scope || cell_scope(header, parent),
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  attr_reader :header, :first_cell_is_header, :parent

  def initialize(parent:, cell_data: nil, first_cell_is_header: false, header: false, classes: [], html_attributes: {})
    @header = header
    @first_cell_is_header = first_cell_is_header
    @parent = parent if parent_valid?(parent)

    super(classes: classes, html_attributes: html_attributes)

    build_cells_from_cell_data(cell_data)
  end

private

  def parent_valid?(supplied_parent)
    return true if supplied_parent.nil?
    return true if supplied_parent.in?(%w(thead tbody))

    fail(ArgumentError, "invalid parent value #{parent}, must be either 'thead' or 'tbody'")
  end

  def build_cells_from_cell_data(cell_data)
    return if cell_data.blank?

    cell_data.each.with_index { |data, i| cell(text: data, **cell_attributes(i)) }
  end

  def cell_attributes(count)
    cell_is_header?(count).then do |cell_is_header|
      { header: cell_is_header, scope: cell_scope(cell_is_header, parent) }
    end
  end

  def cell_scope(is_header, parent)
    return unless is_header

    parent == 'thead' ? 'col' : 'row'
  end

  def cell_is_header?(count)
    header || (first_cell_is_header && count.zero?)
  end

  def default_attributes
    { class: %w(govuk-table__row) }
  end
end
