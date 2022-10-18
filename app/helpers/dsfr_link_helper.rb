module DsfrLinkHelper
  LINK_STYLES = {
    inverse:          "fr-link--inverse",
    muted:            "fr-link--muted",
    no_underline:     "fr-link--no-underline",
    no_visited_state: "fr-link--no-visited-state",
    text_colour:      "fr-link--text-colour",
  }.freeze

  BUTTON_STYLES = {
    disabled:  "fr-btn--disabled",
    secondary: "fr-btn--secondary",
    warning:   "fr-btn--warning",
  }.freeze

  def dsfr_link_classes(*styles, default_class: 'fr-link')
    if (invalid_styles = (styles - LINK_STYLES.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{LINK_STYLES.keys.to_sentence}")
    end

    [default_class] + LINK_STYLES.values_at(*styles).compact
  end

  def dsfr_button_classes(*styles, default_class: 'fr-btn')
    if (invalid_styles = (styles - BUTTON_STYLES.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{BUTTON_STYLES.keys.to_sentence}")
    end

    [default_class] + BUTTON_STYLES.values_at(*styles).compact
  end

  def dsfr_link_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = build_html_options(extra_options)

    if block_given?
      link_to(name, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

  def dsfr_mail_to(email_address, name = nil, extra_options = {}, &block)
    extra_options = name if block_given?
    html_options = build_html_options(extra_options)

    if block_given?
      mail_to(email_address, html_options, &block)
    else
      mail_to(email_address, name, html_options)
    end
  end

  def dsfr_button_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = build_html_options(extra_options, style: :button)

    if block_given?
      button_to(options, html_options, &block)
    else
      button_to(name, options, html_options)
    end
  end

  def dsfr_button_link_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = DsfrComponent::StartButtonComponent::LINK_ATTRIBUTES
      .merge build_html_options(extra_options, style: :button)

    if block_given?
      link_to(name, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

  def dsfr_breadcrumb_link_to(name = nil, options = nil, extra_options = {}, &block)
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
    when :link then dsfr_link_classes(*keys)
    when :button then dsfr_button_classes(*keys)
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

ActiveSupport.on_load(:action_view) { include DsfrLinkHelper }
