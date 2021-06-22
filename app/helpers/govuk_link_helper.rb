module GovukLinkHelper
  LINK_STYLES = {
    muted: "govuk-link--muted",
    no_visited_state: "govuk-link--no-visited-state",
    text_colour: "govuk-link--text-colour",
    inverse: "govuk-link--inverse",
    no_underline: "govuk-link--no-underline",
  }.freeze

  def govuk_link_to(name = nil, options = nil, extra_options = [], &block)
    extra_options = options if block_given?

    html_options = if (style_classes = govuk_link_classes(*extra_options))
                     inject_class(html_options, class_name: style_classes)
                   end

    if block_given?
      link_to(name, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

  def govuk_mail_to(*args, button: false, no_visited_state: false, muted: false, text_colour: false, inverse: false, no_underline: false, **kwargs, &block)
    classes = build_classes(button, no_visited_state, muted, text_colour, inverse, no_underline)

    mail_to(*args, **inject_class(kwargs, class_name: classes), &block)
  end

  def govuk_button_to(*args, **kwargs)
    button_to(*args, **inject_class(kwargs, class_name: 'govuk-button'))
  end

  def govuk_link_classes(*styles, default_class: 'govuk-link')
    if (invalid_styles = (styles - LINK_STYLES.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{LINK_STYLES.keys.to_sentence}")
    end

    [default_class] + LINK_STYLES.values_at(*styles).compact
  end

private

  def inject_class(attributes, class_name:)
    attributes ||= {}

    attributes.with_indifferent_access.tap do |attrs|
      attrs[:class] = Array.wrap(attrs[:class]).prepend(class_name)
    end
  end

  def govuk_button_classes(secondary: false, warning: false, disabled: false)
    [
      'govuk-button',
      secondary_class(secondary),
      warning_class(warning),
      disabled_class(disabled)
    ].compact
  end

  def link_class(button)
    button ? 'govuk-button' : 'govuk-link'
  end

  def muted_class(muted)
    'govuk-link--muted' if muted
  end

  def no_visited_state_class(no_visited_state)
    'govuk-link--no-visited-state' if no_visited_state
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
