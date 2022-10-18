class DsfrComponent::StartButtonComponent < DsfrComponent::Base
  BUTTON_ATTRIBUTES = {
    draggable: 'false',
    data: { module: 'fr-btn' }
  }.freeze

  LINK_ATTRIBUTES = BUTTON_ATTRIBUTES.merge({ role: 'button' }).freeze

  attr_reader :text, :href, :as_button

  def initialize(text:, href:, as_button: config.default_start_button_as_button, classes: [], html_attributes: {})
    @text = text
    @href = href
    @as_button = as_button

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    if as_button
      button_to(href, **html_attributes) do
        safe_join([text, icon])
      end
    else
      link_to(href, **html_attributes) do
        safe_join([text, icon])
      end
    end
  end

private

  def default_attributes
    (as_button ? BUTTON_ATTRIBUTES : LINK_ATTRIBUTES)
      .merge({ class: %w(fr-btn fr-btn--start) })
  end

  def icon
    tag.svg(**svg_attributes) do
      tag.path(fill: "currentColor", d: "M0 0h13l20 20-20 20H0l20-20z")
    end
  end

  def svg_attributes
    {
      class: "fr-btn__start-icon",
      xmlns: "http://www.w3.org/2000/svg",
      width: "17.5",
      height: "19",
      viewBox: "0 0 33 40",
      focusable: "false",
      aria: { hidden: "true" }
    }
  end
end
