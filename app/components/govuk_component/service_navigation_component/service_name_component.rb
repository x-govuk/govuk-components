class GovukComponent::ServiceNavigationComponent::ServiceNameComponent < GovukComponent::Base
  attr_reader :service_name, :service_url

  def initialize(service_name:, service_url:, classes: [], html_attributes: {})
    @service_name = service_name
    @service_url = service_url

    super(classes:, html_attributes:)
  end

  def call
    text = (service_url.present?) ? build_link : build_span

    tag.span(text, **html_attributes)
  end

private

  def build_link
    link_to(service_name, service_url, class: 'govuk-service-navigation__link')
  end

  def build_span
    tag.span(service_name, class: 'govuk-service-navigation__text')
  end

  def default_attributes
    { class: 'govuk-service-navigation__service-name' }
  end
end
