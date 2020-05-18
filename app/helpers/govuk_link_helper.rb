module GovukLinkHelper
  def govuk_link_to(*args, **kwargs)
    link_to(*args, **{ class: 'govuk-link' }.deep_merge(kwargs))
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
