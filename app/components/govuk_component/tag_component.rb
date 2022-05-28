class GovukComponent::TagComponent < GovukComponent::Base
  attr_reader :text, :colour

  COLOURS = %w(grey green turquoise blue red purple pink orange yellow).freeze

  def initialize(text: nil, colour: nil, classes: [], html_attributes: {})
    @text   = text
    @colour = colour

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.strong(tag_content, **html_attributes)
  end

private

  def tag_content
    @text || content || fail(ArgumentError, "no text or content")
  end

  def default_attributes
    {
      class: ["govuk-tag", colour_class]
    }
  end

  def colour_class
    return nil if colour.blank?

    fail(ArgumentError, colour_error_message) unless valid_colour?

    %(govuk-tag--#{colour})
  end

  def valid_colour?
    @colour.in?(COLOURS)
  end

  def colour_error_message
    "invalid tag colour #{colour}, supported colours are #{COLOURS.to_sentence}"
  end
end
