class GovukComponent::SummaryListComponent::KeyComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    @text = text

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.dt(key_content, **html_attributes)
  end

private

  def default_attributes
    { class: "#{ brand }-summary-list__key" }
  end

  def key_content
    content || text || fail(ArgumentError, "no text or content")
  end
end
