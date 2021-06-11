class GovukComponent::BreadcrumbsComponent < GovukComponent::Base
  attr_reader :breadcrumbs, :hide_in_print, :collapse_on_mobile

  def initialize(breadcrumbs:, hide_in_print: false, collapse_on_mobile: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @breadcrumbs        = breadcrumbs
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
end
