require "html_attributes_utils"

module GovukLinkHelper
  using HTMLAttributesUtils

  def govuk_link_to(name, href = nil, new_tab: false, inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false, visually_hidden_prefix: nil, visually_hidden_suffix: nil, **kwargs, &block)
    link_args = extract_link_args(new_tab:, inverse:, muted:, no_underline:, no_visited_state:, text_colour:, **kwargs)
    link_text = build_text(name, visually_hidden_prefix:, visually_hidden_suffix:)

    if block_given?
      link_to(link_text, **link_args, &block)
    else
      link_to(link_text, href, **link_args)
    end
  end

  def govuk_mail_to(email_address, name = nil, new_tab: false, inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false, visually_hidden_prefix: nil, visually_hidden_suffix: nil, **kwargs, &block)
    link_args = extract_link_args(new_tab:, inverse:, muted:, no_underline:, no_visited_state:, text_colour:, **kwargs)
    link_text = build_text(name, visually_hidden_prefix:, visually_hidden_suffix:)

    mail_to(email_address, link_text, **link_args, &block)
  end

  def govuk_button_to(name, href = nil, disabled: false, inverse: false, secondary: false, warning: false, visually_hidden_prefix: nil, visually_hidden_suffix: nil, **kwargs, &block)
    button_args = extract_button_args(new_tab: false, disabled:, inverse:, secondary:, warning:, **kwargs)
    button_text = build_text(name, visually_hidden_prefix:, visually_hidden_suffix:)

    if block_given?
      button_to(name, **button_args, &block)
    else
      button_to(button_text, href, **button_args)
    end
  end

  def govuk_button_link_to(name, href = nil, new_tab: false, disabled: false, inverse: false, secondary: false, warning: false, visually_hidden_prefix: nil, visually_hidden_suffix: nil, **kwargs, &block)
    button_args = extract_button_link_args(new_tab:, disabled:, inverse:, secondary:, warning:, **kwargs)
    button_text = build_text(name, visually_hidden_prefix:, visually_hidden_suffix:)

    if block_given?
      link_to(name, **button_args, &block)
    else
      link_to(button_text, href, **button_args)
    end
  end

  def govuk_breadcrumb_link_to(name, href = nil, **kwargs, &block)
    link_args = { class: "#{brand}-breadcrumbs__link" }.deep_merge_html_attributes(kwargs)

    link_to(name, href, **link_args, &block)
  end

  def govuk_link_classes(inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false)
    if [text_colour, inverse, muted].count(true) > 1
      fail("links can be only be one of text_colour, inverse or muted")
    end

    class_names(
      "#{brand}-link",
      "#{brand}-link--inverse"          => inverse,
      "#{brand}-link--muted"            => muted,
      "#{brand}-link--no-underline"     => no_underline,
      "#{brand}-link--no-visited-state" => no_visited_state,
      "#{brand}-link--text-colour"      => text_colour,
    )
  end

  def govuk_button_classes(inverse: false, secondary: false, warning: false)
    if [inverse, secondary, warning].count(true) > 1
      fail("buttons can only be one of inverse, secondary or warning")
    end

    class_names(
      "#{brand}-button",
      "#{brand}-button--inverse"   => inverse,
      "#{brand}-button--secondary" => secondary,
      "#{brand}-button--warning"   => warning,
    )
  end

private

  def new_tab_args(new_tab)
    new_tab ? { target: "_blank", rel: "noreferrer noopener" } : {}
  end

  def button_attributes(disabled)
    disabled ? { disabled: true, aria: { disabled: true } } : {}
  end

  def extract_link_args(new_tab: false, inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false, **kwargs)
    Rails.logger.warn(actions_warning_message(kwargs.fetch(:action))) if kwargs.key?(:action)
    Rails.logger.warn(controller_warning_message(kwargs.fetch(:controller))) if kwargs.key?(:controller)

    link_classes = extract_link_classes(inverse:, muted:, no_underline:, no_visited_state:, text_colour:)

    { **link_classes, **new_tab_args(new_tab) }.deep_merge_html_attributes(kwargs)
  end

  def extract_button_link_args(new_tab: false, disabled: false, inverse: false, secondary: false, warning: false, **kwargs)
    Rails.logger.warn(actions_warning_message(kwargs.fetch(:action))) if kwargs.key?(:action)
    Rails.logger.warn(controller_warning_message(kwargs.fetch(:controller))) if kwargs.key?(:controller)

    button_classes = extract_button_classes(inverse:, secondary:, warning:)

    { **button_classes, **button_attributes(disabled), **new_tab_args(new_tab) }.deep_merge_html_attributes(kwargs)
  end

  def extract_button_args(disabled: false, inverse: false, secondary: false, warning: false, **kwargs)
    button_classes = extract_button_classes(inverse:, secondary:, warning:)

    { **button_classes, **button_attributes(disabled) }.deep_merge_html_attributes(kwargs)
  end

  def extract_link_classes(inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false)
    {
      class: govuk_link_classes(
        inverse:,
        muted:,
        no_underline:,
        no_visited_state:,
        text_colour:,
      )
    }
  end

  def extract_button_classes(inverse: false, secondary: false, warning: false)
    {
      class: govuk_button_classes(
        inverse:,
        secondary:,
        warning:
      )
    }
  end

  def brand
    Govuk::Components.brand
  end

  def build_text(text, visually_hidden_prefix:, visually_hidden_suffix:)
    return nil if text.nil?

    prefix = (visually_hidden_prefix.present?) ? visually_hidden_prefix + " " : nil
    suffix = (visually_hidden_suffix.present?) ? " " + visually_hidden_suffix : nil

    safe_join([govuk_visually_hidden(prefix), text, govuk_visually_hidden(suffix)].compact)
  end

  def actions_warning_message(value)
    "action: '#{value}' parameter detected Support for old style controller/action links has been removed. See https://github.com/x-govuk/govuk-components/releases/tag/v5.0.0"
  end

  def controller_warning_message(value)
    "controller: '#{value}' parameter detected. Support for old style controller/action links has been removed. See https://github.com/x-govuk/govuk-components/releases/tag/v5.0.0"
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
