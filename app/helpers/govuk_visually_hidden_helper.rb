module GovukVisuallyHiddenHelper
  def govuk_visually_hidden(text = nil, &block)
    return if text.blank? && block.nil?

    tag.span(text, class: "govuk-visually-hidden", &block)
  end
end

ActiveSupport.on_load(:action_view) { include GovukVisuallyHiddenHelper }
