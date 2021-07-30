class GovukComponent::SummaryListComponent::ValueComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.dd(value_content, class: classes, **html_attributes)
  end

private

  def default_classes
    %w(govuk-summary-list__value)
  end

  def value_content
    content || text || fail(ArgumentError, "no text or content")
  end
end
