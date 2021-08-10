class GovukComponent::InsetTextComponent < GovukComponent::Base
  attr_reader :text, :id

  def initialize(text: nil, id: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
    @id   = id
  end

  def call
    tag.div(class: classes, id: id, **html_attributes) { inset_text_content }
  end

  def render?
    inset_text_content.present?
  end

private

  def inset_text_content
    content.presence || text
  end

  def default_classes
    %w(govuk-inset-text)
  end
end
