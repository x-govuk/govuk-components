module GovukLinkHelper
  def govuk_link_to(body, url, html_options = {})
    link_to(body, url, html_options.deep_merge(class: 'govuk-link'))
  end
end

ActiveSupport.on_load(:action_view) { include GovukLinkHelper }
