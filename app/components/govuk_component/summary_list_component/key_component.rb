class GovukComponent::SummaryListComponent::KeyComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.dt(key_content, class: classes, **html_attributes)
  end

private

  def default_classes
    %w(govuk-summary-list__key)
  end

  def key_content
    content || text || fail(ArgumentError, "no text or content")
  end
end
