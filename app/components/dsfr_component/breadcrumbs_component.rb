class DsfrComponent::BreadcrumbsComponent < DsfrComponent::Base
  attr_reader :breadcrumbs, :hide_in_print, :collapse_on_mobile

  def initialize(breadcrumbs:,
                 hide_in_print: config.default_breadcrumbs_hide_in_print,
                 collapse_on_mobile: config.default_breadcrumbs_collapse_on_mobile,
                 classes: [],
                 html_attributes: {})

    @breadcrumbs        = build_list(breadcrumbs)
    @hide_in_print      = hide_in_print
    @collapse_on_mobile = collapse_on_mobile

    super(classes: classes, html_attributes: html_attributes)
  end

private

  def default_attributes
    {
      class: class_names(
        "govuk-breadcrumbs",
        "govuk-!-display-none-print" => hide_in_print,
        "govuk-breadcrumbs--collapse-on-mobile" => collapse_on_mobile
      ).split
    }
  end

  def build_list(breadcrumbs)
    case breadcrumbs
    when Array
      breadcrumbs.map { |item| build_list_item(item) }
    when Hash
      breadcrumbs.map { |text, link| build_list_item(text, link) }
    else
      fail(ArgumentError, "breadcrumbs must be an array or hash")
    end
  end

  def build_list_item(text, link = nil)
    if link.present?
      list_item { link_to(text, link, class: "govuk-breadcrumbs__link") }
    else
      list_item(aria: { current: "page" }) { text.to_s }
    end
  end

  def list_item(html_attributes = {}, &block)
    tag.li(class: "govuk-breadcrumbs__list-item", **html_attributes, &block)
  end
end
