class GovukComponent::BackLinkComponent < GovukComponent::Base
  attr_reader :text, :href

  def initialize(href:, text: config.default_back_link_text, classes: [], html_attributes: {})
    @text = text
    @href = href

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    link_to(link_content, href, **html_attributes)
  end

private

  def link_content
    content || text || fail(ArgumentError, "no text or content")
  end

  def default_attributes
    { class: %w(govuk-back-link) }
  end
end
