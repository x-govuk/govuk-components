class GovukComponent::StartButtonComponent < GovukComponent::Base
  attr_accessor :text, :href

  def initialize(text:, href:, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
    @href = href
  end

  def call
    link_to(@href, **default_attributes, **html_attributes) do
      safe_join([@text, icon])
    end
  end

private

  def default_attributes
    {
      role: 'button',
      draggable: 'false',
      class: classes,
      data: { module: 'govuk-button' }
    }
  end

  def default_classes
    %w(govuk-button govuk-button--start)
  end

  def icon
    svg_attributes = {
      class: "govuk-button__start-icon",
      xmlns: "http://www.w3.org/2000/svg",
      width: "17.5",
      height: "19",
      viewBox: "0 0 33 40",
      focusable: "false",
      aria: { hidden: "true" }
    }

    tag.svg(**svg_attributes) do
      tag.path(fill: "currentColor", d: "M0 0h13l20 20-20 20H0l20-20z")
    end
  end
end
