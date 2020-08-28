class GovukComponent::Tag < GovukComponent::Base
  attr_reader :text

  COLOURS = %w(grey green turquoise blue red purple pink orange yellow).freeze

  def initialize(text:, colour: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text   = text
    @colour = colour
  end

  def call
    tag.strong(@text, class: classes.append(colour_class), **html_attributes)
  end

private

  def default_classes
    %w(govuk-tag)
  end

  def colour_class
    return nil unless @colour.present?

    fail("invalid tag colour #{@colour}, supported colours are #{COLOURS.to_sentence}") unless @colour.in?(COLOURS)

    %(govuk-tag--#{@colour})
  end
end
