class GovukComponent::Footer < ViewComponent::Base
  attr_accessor :licence, :copyright

  def initialize(licence: nil, copyright_text: default_copright_text, copyright_url: default_copyright_url)
    @licence   = licence || default_licence
    @copyright = build_copyright(copyright_text, copyright_url)
  end

private

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
