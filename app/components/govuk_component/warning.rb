class GovukComponent::Warning < GovukComponent::Base
  def initialize(text:, icon_fallback_text: 'Warning', classes: [])
    super(classes: classes)

    @text = text
    @icon_fallback_text = icon_fallback_text
  end

private

  def default_classes
    %w(govuk-warning-text)
  end
end
