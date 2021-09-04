class GovukComponent::BackLinkComponent < GovukComponent::Base
  attr_reader :text, :href

  def initialize(href:, text: 'Back', classes: nil, html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
    @href = href
  end

  def call
    link_to(link_content, href, class: classes, **html_attributes)
  end

private

  def link_content
    content || text || fail(ArgumentError, "no text or content")
  end

  def default_classes
    %w(govuk-back-link)
  end
end
