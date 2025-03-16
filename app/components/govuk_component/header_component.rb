class GovukComponent::HeaderComponent < GovukComponent::Base
  renders_many :navigation_items, "NavigationItem"
  renders_one :custom_logo
  renders_one :product_name, "ProductName"

  attr_reader :homepage_url,
              :service_name,
              :service_url,
              :menu_button_label,
              :navigation_label,
              :custom_navigation_classes,
              :custom_container_classes,
              :full_width_border

  def initialize(classes: [],
                 html_attributes: {},
                 homepage_url: config.default_header_homepage_url,
                 menu_button_label: config.default_header_menu_button_label,
                 navigation_classes: [],
                 navigation_label: config.default_header_navigation_label,
                 service_name: config.default_header_service_name,
                 service_url: config.default_header_service_url,
                 container_classes: nil,
                 full_width_border: false)

    @homepage_url              = homepage_url
    @service_name              = service_name
    @service_url               = service_url
    @menu_button_label         = menu_button_label
    @custom_navigation_classes = navigation_classes
    @navigation_label          = navigation_label
    @custom_container_classes  = container_classes
    @full_width_border         = full_width_border

    super(classes:, html_attributes:)
  end

  def before_render
    if service_name.present? || navigation_items.present?
      Rails.logger.warn('Service name and navigation links are deprecated and will be removed in the next breaking release of GOV.UK Frontend. See https://github.com/alphagov/govuk-frontend/releases/tag/v5.9.0')
    end
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

  def navigation_html_attributes
    nc = ["#{brand}-header__navigation"].append(custom_navigation_classes).compact

    { class: nc, aria: { label: navigation_label } }
  end

  def container_html_attributes
    { class: ["#{brand}-header__container", "#{brand}-width-container"].append(custom_container_classes).compact }
  end

  class NavigationItem < GovukComponent::Base
    attr_reader :text, :href, :options, :active

    def initialize(text:, href: nil, options: {}, active: nil, classes: [], html_attributes: {})
      @text            = text
      @href            = href
      @options         = options
      @active_override = active

      super(classes:, html_attributes:)
    end

    def before_render
      if active?
        html_attributes[:class] << active_class
      end
    end

    def active_class
      ["#{brand}-header__navigation-item--active"] if active?
    end

    def link?
      href.present?
    end

    def call
      tag.li(**html_attributes) do
        if link?
          link_to(text, href, class: "#{brand}-header__link", **options)
        else
          text
        end
      end
    end

  private

    def active?
      return @active_override unless @active_override.nil?
      return false if href.blank?

      current_page?(href)
    end

    def default_attributes
      { class: ["#{brand}-header__navigation-item"] }
    end
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
