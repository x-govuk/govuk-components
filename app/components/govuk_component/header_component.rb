class GovukComponent::HeaderComponent < GovukComponent::Base
  renders_one :custom_logo
  renders_one :product_name, "ProductName"
  renders_one :service_navigation, "GovukComponent::ServiceNavigationComponent"
  renders_one :phase_banner, "GovukComponent::PhaseBannerComponent"

  attr_reader :homepage_url,
              :service_url,
              :custom_container_classes,
              :full_width_border,
              :header_html_attributes

  def initialize(classes: [],
                 html_attributes: {},
                 homepage_url: config.default_header_homepage_url,
                 container_classes: nil,
                 full_width_border: false,
                 header_html_attributes: {})

    @homepage_url              = homepage_url
    @custom_container_classes  = container_classes
    @full_width_border         = full_width_border
    @header_html_attributes    = header_html_attributes

    super(classes:, html_attributes:)
  end

private

  def default_attributes
    {
      class: class_names(
        "#{brand}-header",
        "#{brand}-header--full-width-border" => full_width_border
      )
    }
  end

  def container_html_attributes
    { class: ["#{brand}-header__container", "#{brand}-width-container"].append(custom_container_classes).compact }
  end

  class ProductName < GovukComponent::Base
    attr_reader :name

    def initialize(name: nil, html_attributes: {}, classes: [])
      @name = name

      super(classes:, html_attributes:)
    end

    def render?
      name.present? || content?
    end

    def call
      if content?
        tag.div(content, **html_attributes)
      else
        tag.span(name, **html_attributes)
      end
    end

  private

    def default_attributes
      { class: ["#{brand}-header__product-name"] }
    end
  end
end
