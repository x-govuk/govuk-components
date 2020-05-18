class GovukComponent::Header < ViewComponent::Base
  attr_accessor :logo, :logo_href, :service_name, :service_name_href

  with_content_areas :nav

  def initialize(logo: 'GOV.UK', logo_href: '/', service_name: nil, service_name_href: '/')
    @logo              = logo
    @logo_href         = logo_href
    @service_name      = service_name
    @service_name_href = service_name_href
  end
end
