class GovukComponent::SummaryListComponent::ValueComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.dd(value_content, class: "govuk-summary-list__value")
  end

private

  def value_content
    content || text || fail(ArgumentError, "no text or content")
  end
end
