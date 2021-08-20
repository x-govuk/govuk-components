class GovukComponent::TableComponent::HeadComponent < GovukComponent::Base
  renders_many :rows, GovukComponent::TableComponent::RowComponent

  def initialize(rows: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @row_data = rows
  end

  def call
    tag.thead(class: default_classes)
  end

private

  def default_classes
    %w(govuk-table__head)
  end
end
