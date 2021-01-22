class GovukComponent::Footer < GovukComponent::Base
  include ViewComponent::Slotable

  with_slot :meta_content
  wrap_slot :meta_content

  with_slot :meta
  wrap_slot :meta

  attr_accessor :meta_items, :meta_items_title, :meta_licence, :copyright

  def initialize(meta_items: {}, meta_items_title: "Support links", meta_licence: nil, classes: [], html_attributes: {}, copyright_text: default_copright_text, copyright_url: default_copyright_url)
    super(classes: classes, html_attributes: html_attributes)

    @meta_items       = build_meta_links(meta_items)
    @meta_items_title = meta_items_title
    @meta_licence     = meta_licence
    @copyright        = build_copyright(copyright_text, copyright_url)
  end

private

  def default_classes
    %w(govuk-footer)
  end

  def build_meta_links(links)
    return [] if links.blank?

    fail(ArgumentError, 'meta links must be a hash') unless links.is_a?(Hash)

    links.map { |text, href| raw(link_to(text, href, class: %w(govuk-footer__link))) }
  end

  def default_licence
    link = link_to("Open Government Licence v3.0", "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", class: %w(govuk-footer__link))

    raw(%(All content is available under the #{link}, except where otherwise stated))
  end

  def build_copyright(text, url)
    link_to(text, url, class: %w(govuk-footer__link govuk-footer__copyright-logo))
  end

  def default_copright_text
    raw(%(&copy Crown copyright))
  end

  def default_copyright_url
    "https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/"
  end
end
