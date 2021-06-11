class GovukComponent::InsetTextComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.div(class: classes, **html_attributes) { content.presence || text }
  end

  def render?
    text.present? || content.present?
  end

private

  def default_classes
    %w(govuk-inset-text)
  end
end
