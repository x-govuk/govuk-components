module GovukVisuallyHiddenHelper
  def govuk_visually_hidden(text = nil, focusable: false, &block)
    content = (block_given?) ? block.call : text

    return if content.blank?

    visually_hidden_class = focusable ? "govuk-visually-hidden-focusable" : "govuk-visually-hidden"

    tag.span(content, class: visually_hidden_class)
  end
end

ActiveSupport.on_load(:action_view) { include GovukVisuallyHiddenHelper }
