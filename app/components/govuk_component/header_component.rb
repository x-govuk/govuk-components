class GovukComponent::HeaderComponent < GovukComponent::Base
  renders_one :custom_logo
  renders_one :product_name, "ProductName"

  attr_reader :homepage_url,
              :service_name,
              :service_url,
              :menu_button_label,
              :custom_container_classes,
              :full_width_border

  def initialize(classes: [],
                 html_attributes: {},
                 homepage_url: config.default_header_homepage_url,
                 menu_button_label: config.default_header_menu_button_label,
                 container_classes: nil,
                 full_width_border: false)

    @homepage_url              = homepage_url
    @service_name              = service_name
    @service_url               = service_url
    @menu_button_label         = menu_button_label
    @custom_container_classes  = container_classes
    @full_width_border         = full_width_border

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
