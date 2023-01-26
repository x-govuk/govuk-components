class GovukComponent::TableComponent::RowComponent < GovukComponent::Base
  renders_many :cells, ->(scope: nil, header: nil, text: nil, numeric: false, width: nil, classes: [], html_attributes: {}, &block) do
    GovukComponent::TableComponent::CellComponent.new(
      scope: scope,
      header: header,
      text: text,
      numeric: numeric,
      width: width,
      parent: parent,
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  attr_reader :first_cell_is_header, :parent

  def initialize(cell_data: nil, first_cell_is_header: false, parent: nil, classes: [], html_attributes: {})
    @first_cell_is_header = first_cell_is_header
    @parent = parent

    super(classes: classes, html_attributes: html_attributes)

    build_cells_from_cell_data(cell_data)
  end

  def self.from_head(*args, **kwargs, &block)
    new(*args, parent: 'thead', **kwargs, &block)
  end

  def self.from_body(*args, **kwargs, &block)
    new(*args, parent: 'tbody', **kwargs, &block)
  end

  def self.from_foot(*args, **kwargs, &block)
    new(*args, parent: 'tfoot', **kwargs, &block)
  end

  def call
    tag.tr(**html_attributes) { safe_join(cells) }
  end

private

  def build_cells_from_cell_data(cell_data)
    return if cell_data.blank?

    cell_data.each_with_index do |data, i|
      case data
      when Hash
        with_cell(**data, **cell_attributes(i))
      when String
        with_cell(text: data, **cell_attributes(i))
      end
    end
  end

  def cell_attributes(count)
    cell_is_header?(count).then do |cell_is_header|
      { header: cell_is_header }
    end
  end

  def cell_is_header?(count)
    in_thead? || (first_cell_is_header && count.zero?)
  end

  def default_attributes
    { class: %w(govuk-table__row) }
  end

  def in_thead?
    parent == "thead"
  end
end
