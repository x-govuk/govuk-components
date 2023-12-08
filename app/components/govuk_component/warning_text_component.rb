class GovukComponent::WarningTextComponent < GovukComponent::Base
  attr_reader :text, :icon, :icon_fallback_text

  def initialize(text: nil, icon_fallback_text: config.default_warning_text_icon_fallback_text, icon: config.default_warning_text_icon, classes: [], html_attributes: {})
    @text = text
    @icon = icon
    @icon_fallback_text = icon_fallback_text

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(**html_attributes) do
      safe_join([icon_element, warning_text])
    end
  end

private

  def icon_element
    tag.span(icon, class: "#{brand}-warning-text__icon", aria: { hidden: true })
  end

  def warning_text
    tag.strong(class: "#{brand}-warning-text__text") do
      safe_join([visually_hidden_text, (content || text)])
    end
  end

  def visually_hidden_text
    tag.span(icon_fallback_text, class: "#{brand}-visually-hidden")
  end

  def default_attributes
    { class: "#{brand}-warning-text" }
  end
end
