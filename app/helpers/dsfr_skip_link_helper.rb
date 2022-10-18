module DsfrSkipLinkHelper
  def dsfr_skip_link(text: 'Skip to main content', href: '#main-content', classes: [], **html_attributes, &block)
    link_classes = Array.wrap(classes).append('govuk-skip-link')

    html_attributes_with_data_module = { data: { module: "govuk-skip-link" } }.deep_merge(html_attributes)

    return link_to(href, class: link_classes, **html_attributes_with_data_module, &block) if block_given?

    link_to(text, href, class: link_classes, **html_attributes_with_data_module)
  end
end

ActiveSupport.on_load(:action_view) { include DsfrSkipLinkHelper }
