class Tag::TagComponent < ViewComponent::Base
  attr_reader :text

  def initialize(text:, colour: nil)
    @text = text
    @colour = colour
  end

  def css_classes
    @colour ? "govuk-tag--#{@colour}" : ''
  end
end
