class GovukComponent::Warning < ViewComponent::Base
  def initialize(text:, icon_fallback_text: 'Warning', classes: [])
    @text = text
    @icon_fallback_text = icon_fallback_text
    @classes = Array.wrap(classes)
  end
end
