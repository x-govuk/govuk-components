class GovukComponent::HeaderComponent < GovukComponent::Base
  renders_many :navigation_items, "NavigationItem"
  renders_one :custom_logo
  renders_one :product_name, "ProductName"

  attr_reader :logotype,
              :crown,
              :crown_fallback_image,
              :homepage_url,
              :service_name,
              :service_url,
              :menu_button_label,
              :navigation_label,
              :custom_navigation_classes,
              :custom_container_classes

  def initialize(classes: [],
                 html_attributes: {},
                 logotype: 'GOV.UK',
                 crown: true,
                 crown_fallback_image: nil,
                 homepage_url: '/',
                 menu_button_label: 'Show or hide navigation menu',
                 navigation_classes: [],
                 navigation_label: 'Navigation menu',
                 service_name: nil,
                 service_url: '/',
                 container_classes: nil)

    super(classes: classes, html_attributes: html_attributes)

    @logotype                  = logotype
    @crown                     = crown
    @crown_fallback_image      = crown_fallback_image
    @homepage_url              = homepage_url
    @service_name              = service_name
    @service_url               = service_url
    @menu_button_label         = menu_button_label
    @custom_navigation_classes = navigation_classes
    @navigation_label          = navigation_label
    @custom_container_classes  = container_classes
  end

private

  def default_classes
    %w(govuk-header)
  end

  def navigation_classes
    combine_classes(%w(govuk-header__navigation), custom_navigation_classes)
  end

  def container_classes
    combine_classes(%w(govuk-header__container govuk-width-container), custom_container_classes)
  end

  def crown_fallback_image_attributes
    {
      class: "govuk-header__logotype-crown-fallback-image",
      width: "36",
      height: "32",
      "xlink:href" => "",
    }
  end

  class NavigationItem < GovukComponent::Base
    attr_reader :text, :href, :options, :active

    def initialize(text:, href: nil, options: {}, active: nil, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @text    = text
      @href    = href
      @options = options

      @active_override = active
    end

    def before_render
      @active = active?(@active_override)
    end

    def active_class
      %w(govuk-header__navigation-item--active) if @active
    end

    def link?
      href.present?
    end

    def call
      tag.li(class: classes.append(active_class), **html_attributes) do
        if link?
          link_to(text, href, **options, class: "govuk-header__link")
        else
          text
        end
      end
    end

  private

    def active?(active_override)
      return current_page?(href) if active_override.nil?

      active_override
    end

    def default_classes
      %w(govuk-header__navigation-item)
    end
  end

  class ProductName < GovukComponent::Base
    attr_reader :name

    def initialize(name: nil, html_attributes: {}, classes: [])
      super(classes: classes, html_attributes: html_attributes)

      @name = name
    end

    def render?
      name.present? || content.present?
    end

    def call
      if content.present?
        tag.div(content, class: classes)
      else
        tag.span(name, class: classes)
      end
    end

  private

    def default_classes
      %w(govuk-header__product-name)
    end
  end
end
