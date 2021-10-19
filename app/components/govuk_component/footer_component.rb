class GovukComponent::FooterComponent < GovukComponent::Base
  renders_one :meta_html
  renders_one :meta
  renders_one :navigation

  attr_reader :meta_items, :meta_text, :meta_items_title, :meta_licence, :copyright, :custom_container_classes

  def initialize(
    classes: [],
    container_classes: [],
    container_html_attributes: {},
    copyright_text: default_copright_text,
    copyright_url: default_copyright_url,
    html_attributes: {},
    meta_items: {},
    meta_items_title: "Support links",
    meta_licence: nil,
    meta_text: nil,
    meta_classes: [],
    meta_html_attributes: {}
  )
    super(classes: classes, html_attributes: html_attributes)

    @meta_text                        = meta_text
    @meta_items                       = build_meta_links(meta_items)
    @meta_items_title                 = meta_items_title
    @meta_licence                     = meta_licence
    @custom_meta_classes              = meta_classes
    @custom_meta_html_attributes      = meta_html_attributes
    @copyright                        = build_copyright(copyright_text, copyright_url)
    @custom_container_classes         = container_classes
    @custom_container_html_attributes = container_html_attributes
  end

private

  def default_classes
    %w(govuk-footer)
  end

  def container_classes
    combine_classes(%w(govuk-width-container), custom_container_classes)
  end

  def meta_content
    meta_html || meta_text
  end

  def meta_classes
    %w(govuk-footer__meta).append(@custom_meta_classes)
  end

  def meta_html_attributes
    @custom_meta_html_attributes
  end

  def container_html_attributes
    @custom_container_html_attributes
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
