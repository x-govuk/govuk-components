class GovukComponent::StartButtonComponent < GovukComponent::Base
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
    attrs = {
      class: ["#{ brand }-button", "#{ brand }-button--start"],
      data: { module: "#{ brand }-button" },
      draggable: 'false',
    }
    attrs.merge!(role: 'button') unless as_button
    attrs
  end

  def icon
    tag.svg(**svg_attributes) do
      tag.path(fill: "currentColor", d: "M0 0h13l20 20-20 20H0l20-20z")
    end
  end

  def svg_attributes
    {
      class: "#{ brand }-button__start-icon",
      xmlns: "http://www.w3.org/2000/svg",
      width: "17.5",
      height: "19",
      viewBox: "0 0 33 40",
      focusable: "false",
      aria: { hidden: "true" }
    }
  end
end
