module GovukSkipLinkHelper
  def govuk_skip_link(text: 'Skip to main content', href: '#main-content', classes: [], **html_attributes, &block)
    link_classes = Array.wrap(classes).append('govuk-skip-link')

    return link_to(href, class: link_classes, **html_attributes, &block) if block_given?

    link_to(text, href, class: link_classes, **html_attributes)
  end
end

ActiveSupport.on_load(:action_view) { include GovukSkipLinkHelper }
