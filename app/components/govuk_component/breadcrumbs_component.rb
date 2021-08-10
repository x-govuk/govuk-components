class GovukComponent::BreadcrumbsComponent < GovukComponent::Base
  attr_reader :breadcrumbs, :hide_in_print, :collapse_on_mobile

  def initialize(breadcrumbs:, hide_in_print: false, collapse_on_mobile: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @breadcrumbs        = build_list(breadcrumbs)
    @hide_in_print      = hide_in_print
    @collapse_on_mobile = collapse_on_mobile
  end

private

  def default_classes
    %w(govuk-breadcrumbs).tap do |classes|
      classes << "govuk-!-display-none-print" if hide_in_print
      classes << "govuk-breadcrumbs--collapse-on-mobile" if collapse_on_mobile
    end
  end

  def build_list(breadcrumbs)
    case breadcrumbs
    when Array
      breadcrumbs.map { |item| build_list_item(item) }
    when Hash
      breadcrumbs.map { |text, link| build_list_item(text, link) }
    else
      fail(ArgumentError, "breadcrumb must be an array or hash")
    end
  end

  def build_list_item(text, link = nil)
    if link.present?
      list_item { link_to(text, link, class: "govuk-breadcrumbs__link") }
    else
      list_item(aria: { current: "page" }) { text }
    end
  end

  def list_item(html_attributes = {}, &block)
    tag.li(class: "govuk-breadcrumbs__list-item", **html_attributes, &block)
  end
end
