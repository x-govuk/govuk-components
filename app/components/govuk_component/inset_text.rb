class GovukComponent::InsetText < GovukComponent::Base
  attr_accessor :text

  def initialize(text:, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.div(class: classes, **html_attributes) { @text }
  end

private

  def default_classes
    %w(govuk-inset-text)
  end
end
