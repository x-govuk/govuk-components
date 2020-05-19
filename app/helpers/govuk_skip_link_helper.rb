module GovukSkipLinkHelper
  def govuk_skip_link(text: 'Skip to main content', href: '#main-content')
    link_to text, href, class: 'govuk-skip-link'
  end
end
ActiveSupport.on_load(:action_view) { include GovukSkipLinkHelper }
