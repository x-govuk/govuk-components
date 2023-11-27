module GovukVisuallyHiddenHelper
  def govuk_visually_hidden(text, focusable: false)
    return if text.nil?

    visually_hidden_class = focusable ? "govuk-visually-hidden-focusable" : "govuk-visually-hidden"

    tag.span(text, class: visually_hidden_class)
  end
end

ActiveSupport.on_load(:action_view) { include GovukSkipLinkHelper }
