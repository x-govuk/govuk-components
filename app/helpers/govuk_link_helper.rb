module GovukLinkHelper
  def govuk_link_classes(no_visited_state: false, muted: false, text_colour: false, inverse: false, no_underline: false)
    [
      'govuk-link',
      no_visited_state_class(no_visited_state),
      muted_class(muted),
      text_colour_class(text_colour),
      inverse_class(inverse),
      no_underline_class(no_underline),
    ].compact
  end

  def govuk_button_classes(secondary: false, warning: false, disabled: false)
    [
      'govuk-button',
      secondary_class(secondary),
      warning_class(warning),
      disabled_class(disabled)
    ].compact
  end

private

  def no_visited_state_class(no_visited_state)
    'govuk-link--no-visited-state' if no_visited_state
  end

  def muted_class(muted)
    'govuk-link--muted' if muted
  end

  def text_colour_class(colour)
    'govuk-link--text-colour' if colour
  end

  def inverse_class(inverse)
    'govuk-link--inverse' if inverse
  end

  def no_underline_class(no_underline)
    'govuk-link--no-underline' if no_underline
  end

  def secondary_class(secondary)
    'govuk-button--secondary' if secondary
  end

  def warning_class(warning)
    'govuk-button--warning' if warning
  end

  def disabled_class(disabled)
    'govuk-button--disabled' if disabled
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
