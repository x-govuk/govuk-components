class GovukComponent::WarningTextComponent < GovukComponent::Base
  attr_reader :text, :assistive_text

  ICON = '!'.freeze

  def initialize(text:, assistive_text: 'Warning', classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
    @assistive_text = assistive_text
  end

  def call
    tag.div(class: classes, **html_attributes) do
      safe_join([icon, strong])
    end
  end

private

  def icon
    tag.span(ICON, class: 'govuk-warning-text__icon', aria: { hidden: true })
  end

  def strong
    tag.strong(class: 'govuk-warning-text__text') do
      safe_join([assistive, text])
    end
  end

  def assistive
    tag.span(assistive_text, class: 'govuk-warning-text__assistive')
  end

  def default_classes
    %w(govuk-warning-text)
  end
end
