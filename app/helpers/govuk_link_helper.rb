module GovukLinkHelper
  def govuk_link_to(*args, button: false, **kwargs, &block)
    link_to(*args, **{ class: link_class(button) }.deep_merge(kwargs), &block)
  end

  def govuk_mail_to(*args, **kwargs, &block)
    mail_to(*args, **{ class: 'govuk-link' }.deep_merge(kwargs), &block)
  end

  def govuk_button_to(*args, **kwargs)
    button_to(*args, **{ class: 'govuk-button' }.deep_merge(kwargs))
  end

private

  def link_class(button)
    button ? 'govuk-button' : 'govuk-link'
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
