class GovukComponent::WarningTextComponent < GovukComponent::Base
  attr_reader :text, :icon_fallback_text

  ICON = '!'.freeze

  def initialize(text: nil, icon_fallback_text: 'Warning', classes: [], html_attributes: {})
    @text = text
    @icon_fallback_text = icon_fallback_text

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(**html_attributes) do
      safe_join([icon, warning_text])
    end
  end

private

  def icon
    tag.span(ICON, class: 'govuk-warning-text__icon', aria: { hidden: true })
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
