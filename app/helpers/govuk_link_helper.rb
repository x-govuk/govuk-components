require "html_attributes_utils"

module GovukLinkHelper
  using HTMLAttributesUtils

  def govuk_link_classes(*styles, default_class: "#{brand}-link")
    if (invalid_styles = (styles - link_styles.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{link_styles.keys.to_sentence}")
    end

    [default_class] + link_styles.values_at(*styles).compact
  end

  def govuk_button_classes(*styles, default_class: "#{brand}-button")
    if (invalid_styles = (styles - button_styles.keys)) && invalid_styles.any?
      fail(ArgumentError, "invalid styles #{invalid_styles.to_sentence}. Valid styles are #{button_styles.keys.to_sentence}")
    end

    [default_class] + button_styles.values_at(*styles).compact
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
      button_to(options, html_options, &block)
    else
      button_to(name, options, html_options)
    end
  end

  def govuk_button_link_to(name = nil, options = nil, extra_options = {}, &block)
    extra_options = options if block_given?
    html_options = {
      data: { module: "#{brand}-button" },
      draggable: 'false',
      role: 'button',
    }.merge build_html_options(extra_options, style: :button)

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

  def brand
    Govuk::Components.brand
  end

  def link_styles
    {
      inverse:          "#{brand}-link--inverse",
      muted:            "#{brand}-link--muted",
      no_underline:     "#{brand}-link--no-underline",
      no_visited_state: "#{brand}-link--no-visited-state",
      text_colour:      "#{brand}-link--text-colour",
    }
  end

  def button_styles
    {
      disabled:  "#{brand}-button--disabled",
      secondary: "#{brand}-button--secondary",
      warning:   "#{brand}-button--warning",
      inverse:   "#{brand}-button--inverse",
    }
  end

  def build_html_options(provided_options, style: :link)
    element_styles = { link: link_styles, button: button_styles }.fetch(style, {})

    # we need to take a couple of extra steps here because we don't want the style
    # params (inverse, muted, etc) to end up as extra attributes on the link.

    remaining_options = remove_styles_from_provided_options(element_styles, provided_options)

    style_classes = build_style_classes(style, extract_styles_from_provided_options(element_styles, provided_options))

    combine_attributes(remaining_options, class_name: style_classes)
  end

  def build_style_classes(style, provided_options)
    keys = *provided_options&.keys

    case style
    when :link then govuk_link_classes(*keys)
    when :button then govuk_button_classes(*keys)
    when :breadcrumb then "#{brand}-breadcrumbs__link"
    end
  end

  def combine_attributes(attributes, class_name:)
    attributes ||= {}

    attributes.with_indifferent_access.tap do |attrs|
      attrs[:class] = Array.wrap(attrs[:class]).prepend(class_name).flatten.join(" ")
    end
  end

  def extract_styles_from_provided_options(styles, provided_options)
    return {} if provided_options.blank?

    provided_options.slice(*styles.keys)
  end

  def remove_styles_from_provided_options(styles, provided_options)
    return {} if provided_options.blank?

    provided_options&.except(*styles.keys)
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
