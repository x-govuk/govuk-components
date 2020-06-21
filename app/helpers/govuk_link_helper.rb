module GovukLinkHelper
  def govuk_link_to(*args, **kwargs)
    link_to(*args, **{ class: 'govuk-link' }.deep_merge(kwargs))
  end

  def govuk_mail_to(*args, **kwargs)
    mail_to(*args, **{ class: 'govuk-link' }.deep_merge(kwargs))
  end

  def govuk_button_to(*args, **kwargs)
    button_to(*args, **{ class: 'govuk-button' }.deep_merge(kwargs))
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
