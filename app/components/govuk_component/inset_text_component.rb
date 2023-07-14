class GovukComponent::InsetTextComponent < GovukComponent::Base
  attr_reader :text, :id

  def initialize(text: nil, id: nil, classes: [], html_attributes: {})
    @text = text
    @id   = id

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(id: id, **html_attributes) { inset_text_content }
  end

  def render?
    inset_text_content.present?
  end

private

  def inset_text_content
    content.presence || text
  end

  def default_attributes
    { class: ["#{brand}-inset-text"] }
  end
end
