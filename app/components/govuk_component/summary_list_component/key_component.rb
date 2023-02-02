class GovukComponent::SummaryListComponent::KeyComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, html_attributes: {})
    @text = text

    super(html_attributes: html_attributes)
  end

  def call
    tag.dt(key_content, **html_attributes)
  end

private

  def default_attributes
    { class: %w(govuk-summary-list__key) }
  end

  def key_content
    content || text || fail(ArgumentError, "no text or content")
  end
end
