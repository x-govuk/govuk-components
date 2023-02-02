module GovukSkipLinkHelper
  using HTMLAttributesUtils

  def govuk_skip_link(text: 'Skip to main content', href: '#main-content', html_attributes: {}, &block)
    html_attributes_with_data_module = { class: 'govuk-skip-link', data: { module: "govuk-skip-link" } }.deep_merge_html_attributes(html_attributes)

    return link_to(href, **html_attributes_with_data_module, &block) if block_given?

    link_to(text, href, **html_attributes_with_data_module)
  end
end

ActiveSupport.on_load(:action_view) { include GovukSkipLinkHelper }
