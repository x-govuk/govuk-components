class GovukComponent::Footer < ViewComponent::Base
  attr_accessor :meta, :licence, :copyright

  def initialize(meta_links: nil, meta_heading: default_meta_heading, licence: nil, copyright_text: default_copright_text, copyright_url: default_copyright_url)
    @meta_links   = build_meta_links(meta_links)
    @meta_heading = raw(tag.h2(meta_heading, class: 'govuk-visually-hidden'))
    @licence      = licence || default_licence
    @copyright    = build_copyright(copyright_text, copyright_url)
  end

private

  def build_meta_links(links)
    return [] if links.blank?

    fail(ArgumentError, 'meta links must be a hash') unless links.is_a?(Hash)

    links.map { |text, href| raw(link_to(text, href, class: %w(govuk-footer__link))) }
  end

  def default_meta_heading
    'Supporting links'
  end

  def default_licence
    link = link_to("Open Government Licence v3.0", "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/")

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
