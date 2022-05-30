module GovukLinkHelper
  LINK_STYLES = {
    inverse:          "govuk-link--inverse",
    muted:            "govuk-link--muted",
    no_underline:     "govuk-link--no-underline",
    no_visited_state: "govuk-link--no-visited-state",
    text_colour:      "govuk-link--text-colour",
  }.freeze

  BUTTON_STYLES = {
    disabled:  "govuk-button--disabled",
    secondary: "govuk-button--secondary",
    warning:   "govuk-button--warning",
  }.freeze

  def govuk_link_classes(*styles, default_class: 'govuk-link')
    if (invalid_styles = (styles - LINK_STYLES.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{LINK_STYLES.keys.to_sentence}")
    end

    [default_class] + LINK_STYLES.values_at(*styles).compact
  end

  def govuk_button_classes(*styles, default_class: 'govuk-button')
    if (invalid_styles = (styles - BUTTON_STYLES.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{BUTTON_STYLES.keys.to_sentence}")
    end

    [default_class] + BUTTON_STYLES.values_at(*styles).compact
  end

  def govuk_link_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = build_html_options(extra_options)

    if block_given?
      link_to(name, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

  def govuk_mail_to(email_address, name = nil, extra_options = {}, &block)
    extra_options = name if block_given?
    html_options = build_html_options(extra_options)

    if block_given?
      mail_to(email_address, html_options, &block)
    else
      mail_to(email_address, name, html_options)
    end
  end

  def govuk_button_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = build_html_options(extra_options, style: :button)

    if block_given?
      if Rails.version >= "7.0.0" && name.is_a?(Hash)
        button_to(name.merge(html_options), &block)
      else
        button_to(name, html_options, &block)
      end
    else
      button_to(name, options, html_options)
    end
  end

  def govuk_button_link_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = GovukComponent::StartButtonComponent::BUTTON_ATTRIBUTES
      .merge build_html_options(extra_options, style: :button)

    if block_given?
      link_to(name, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

  def govuk_breadcrumb_link_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = build_html_options(extra_options, style: :breadcrumb)

    if block_given?
      link_to(name, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

private

  def build_html_options(provided_options, style: :link)
    styles = case style
             when :link       then LINK_STYLES
             when :button     then BUTTON_STYLES
             else {}
             end

    remaining_options = provided_options&.slice!(*styles.keys)

    return {} unless (style_classes = build_style_classes(style, provided_options))

    inject_class(remaining_options, class_name: style_classes)
  end

  def build_style_classes(style, provided_options)
    keys = *provided_options&.keys

    case style
    when :link then govuk_link_classes(*keys)
    when :button then govuk_button_classes(*keys)
    when :breadcrumb then %w(govuk-breadcrumbs__link)
    end
  end

  def inject_class(attributes, class_name:)
    attributes ||= {}

    attributes.with_indifferent_access.tap do |attrs|
      attrs[:class] = Array.wrap(attrs[:class]).prepend(class_name).flatten.join(" ")
    end
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
