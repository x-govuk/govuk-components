module GovukLinkHelper
  def govuk_link_to(*args, button: false, **kwargs, &block)
    link_to(*args, **inject_class(kwargs, class_name: link_class(button)), &block)
  end

  def govuk_mail_to(*args, button: false, **kwargs, &block)
    mail_to(*args, **inject_class(kwargs, class_name: link_class(button)), &block)
  end

  def govuk_button_to(*args, **kwargs)
    button_to(*args, **inject_class(kwargs, class_name: 'govuk-button'))
  end

private

  def inject_class(attributes, class_name:)
    attributes.with_indifferent_access.tap do |attrs|
      attrs[:class] = Array.wrap(attrs[:class]).prepend(class_name)
    end
  end

  def link_class(button)
    button ? 'govuk-button' : 'govuk-link'
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
