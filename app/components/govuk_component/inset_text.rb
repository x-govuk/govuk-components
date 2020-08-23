class GovukComponent::InsetText < GovukComponent::Base
  attr_accessor :text

  def initialize(text:, classes: [])
    super(classes: classes)

    @text = text
  end

  def call
    tag.div(class: classes) { @text }
  end

private

  def default_classes
    %w(govuk-inset-text)
  end
end
