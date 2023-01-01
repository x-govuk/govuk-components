class GovukComponent::TableComponent::FootComponent < GovukComponent::Base
  renders_many :rows, ->(cell_data: nil, classes: [], html_attributes: {}, &block) do
    GovukComponent::TableComponent::RowComponent.from_foot(
      cell_data: cell_data,
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  attr_reader :row_data

  def initialize(classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.tfoot(**html_attributes) { safe_join(rows) }
  end

private

  def default_attributes
    { class: %w(govuk-table__foot) }
  end
end
