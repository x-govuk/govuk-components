class DsfrComponent::WarningTextComponent < DsfrComponent::Base
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
    tag.span(icon, class: 'govuk-warning-text__icon', aria: { hidden: true })
  end

  def warning_text
    tag.strong(class: 'govuk-warning-text__text') do
      safe_join([assistive, (content || text)])
    end
  end

  def assistive
    tag.span(icon_fallback_text, class: 'govuk-warning-text__assistive')
  end

  def default_attributes
    { class: %w(govuk-warning-text) }
  end
end
