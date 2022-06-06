class GovukComponent::StartButtonComponent < GovukComponent::Base
  BUTTON_ATTRIBUTES = {
    role: 'button',
    draggable: 'false',
    data: { module: 'govuk-button' }
  }.freeze

  attr_reader :text, :href

  def initialize(text:, href:, classes: [], html_attributes: {})
    @text = text
    @href = href

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    link_to(href, **html_attributes) do
      safe_join([text, icon])
    end
  end

private

  def default_attributes
    BUTTON_ATTRIBUTES.merge({ class: %w(govuk-button govuk-button--start) })
  end

  def icon
    tag.svg(**svg_attributes) do
      tag.path(fill: "currentColor", d: "M0 0h13l20 20-20 20H0l20-20z")
    end
  end

  def svg_attributes
    {
      class: "govuk-button__start-icon",
      xmlns: "http://www.w3.org/2000/svg",
      width: "17.5",
      height: "19",
      viewBox: "0 0 33 40",
      focusable: "false",
      aria: { hidden: "true" }
    }
  end
end
