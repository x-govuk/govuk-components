class GovukComponent::HeaderComponent < GovukComponent::Base
  renders_many :navigation_items, "NavigationItem"
  renders_one :custom_logo
  renders_one :product_name, "ProductName"

  attr_reader :logotype,
              :crown,
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

  class NavigationItem < GovukComponent::Base
    attr_reader :text, :href, :active

    def initialize(text:, href: nil, active: false, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @text   = text
      @href   = href
      @active = active
    end

    def active?
      active
    end

    def active_class
      %w(govuk-header__navigation-item--active) if active?
    end

    def link?
      href.present?
    end

  private

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
