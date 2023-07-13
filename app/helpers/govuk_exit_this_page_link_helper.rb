module GovukExitThisPageLinkHelper
  def govuk_exit_this_page_link(
    text: Govuk::Components.config.default_exit_this_page_text,
    href: Govuk::Components.config.default_exit_this_page_redirect_url,
    classes: [],
    **html_attributes,
    &block
  )
    link_classes = Array.wrap(classes).append(%w(govuk-skip-link govuk-js-exit-this-page-skiplink))

    html_attributes_with_data_module = { data: { module: "govuk-skip-link" } }.deep_merge(html_attributes)

    link_to(text, href, class: link_classes, **html_attributes_with_data_module, &block)
  end
end

ActiveSupport.on_load(:action_view) { include GovukExitThisPageLinkHelper }
