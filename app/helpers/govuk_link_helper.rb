require "html_attributes_utils"

module GovukLinkHelper
  using HTMLAttributesUtils

  def govuk_link_to(name, href = nil, new_tab: false, inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false, **kwargs, &block)
    link_args = extract_link_args(new_tab: new_tab, inverse: inverse, muted: muted, no_underline: no_underline, no_visited_state: no_visited_state, text_colour: text_colour, **kwargs)

    if block_given?
      link_to(block.call, href, **link_args)
    else
      link_to(name, href, **link_args)
    end
  end

  def govuk_mail_to(email_address, name = nil, new_tab: false, inverse: false, muted: false, no_underline: false, no_visited_state: false, text_colour: false, **kwargs, &block)
    link_args = extract_link_args(new_tab: new_tab, inverse: inverse, muted: muted, no_underline: no_underline, no_visited_state: no_visited_state, text_colour: text_colour, **kwargs)

    if block_given?
      mail_to(email_address, block.call, **link_args)
    else
      mail_to(email_address, name, **link_args)
    end
  end

  def govuk_button_to(name, href = nil, disabled: false, inverse: false, secondary: false, warning: false, **kwargs, &block)
    button_args = extract_button_args(new_tab: false, disabled: disabled, inverse: inverse, secondary: secondary, warning: warning, **kwargs)

    if block_given?
      button_to(block.call, href, **button_args)
    else
      button_to(name, href, **button_args)
    end
  end

  def govuk_button_link_to(name, href = nil, new_tab: false, disabled: false, inverse: false, secondary: false, warning: false, **kwargs, &block)
    button_args = extract_button_args(new_tab: new_tab, disabled: disabled, inverse: inverse, secondary: secondary, warning: warning, **kwargs)

    if block_given?
      link_to(block.call, href, **button_args)
    else
      link_to(name, href, **button_args)
    end
  end

  def govuk_breadcrumb_link_to(name, href = nil, **kwargs, &block)
    link_args = { class: "#{brand}-breadcrumbs--link" }.deep_merge_html_attributes(kwargs)

    if block_given?
      link_to(block.call, href, **link_args)
    else
      link_to(name, href, **link_args)
    end
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

  def govuk_button_classes(disabled: false, inverse: false, secondary: false, warning: false)
    if [inverse, secondary, warning].count(true) > 1
      fail("buttons can only be one of inverse, secondary or warning")
    end

    class_names(
      "#{brand}-button",
      "#{brand}-button--disabled"  => disabled,
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
    {
      class: govuk_link_classes(
        inverse: inverse,
        muted: muted,
        no_underline: no_underline,
        no_visited_state: no_visited_state,
        text_colour: text_colour
      ),
      **new_tab_args(new_tab)
    }.deep_merge_html_attributes(kwargs)
  end

  def extract_button_args(new_tab: false, disabled: false, inverse: false, secondary: false, warning: false, **kwargs)
    {
      class: govuk_button_classes(
        disabled: disabled,
        inverse: inverse,
        secondary: secondary,
        warning: warning
      ),
      **button_attributes(disabled),
      **new_tab_args(new_tab)
    }.deep_merge_html_attributes(kwargs)
  end

  def brand
    Govuk::Components.brand
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
