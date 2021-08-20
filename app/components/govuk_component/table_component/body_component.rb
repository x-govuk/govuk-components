class GovukComponent::TableComponent::BodyComponent < GovukComponent::Base
  renders_many :rows, GovukComponent::TableComponent::RowComponent

  def initialize(rows: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @row_data = rows
  end

  def call
    tag.tbody(class: default_classes)
  end
end
