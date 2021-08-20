class GovukComponent::TableComponent::DataCellComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.td(text, class: default_classes, **html_attributes)
  end

private

  def default_classes
    %(govuk-table__cell)
  end
end
