class GovukComponent::TableComponent::HeadComponent < GovukComponent::Base
  renders_many :rows, GovukComponent::TableComponent::RowComponent

  attr_reader :row_data

  def initialize(rows: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @row_data = rows
  end

  def call
    tag.thead(class: classes) { head_content }
  end

private

  def head_content
    rows.presence || build_rows
  end

  def build_rows
    safe_join(row_data.map { |rd| row(cell_data: rd, header: true) })
  end

  def default_classes
    %w(govuk-table__head)
  end
end
