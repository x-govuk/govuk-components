class GovukComponent::SummaryListComponent::KeyComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.dt(text, class: "govuk-summary-list__key")
  end

private

  def key_content
    content || text || fail(ArgumentError, "no text or content")
  end
end
