class GovukComponent::Header < GovukComponent::Base
  include ViewComponent::Slotable

  attr_accessor :logo, :logo_href, :service_name, :service_name_href, :product_name, :menu_button_label, :navigation_label

  with_slot :item, collection: true, class_name: 'Item'
  # wrap_slot :item

  with_slot :product_description
  # wrap_slot :product_description

  def initialize(logo: 'GOV.UK', logo_href: '/', service_name: nil, service_name_href: '/', product_name: nil, menu_button_label: 'Show or hide navigation menu', classes: [], navigation_classes: [], navigation_label: 'Navigation menu', html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @logo               = logo
    @logo_href          = logo_href
    @service_name       = service_name
    @service_name_href  = service_name_href
    @product_name       = product_name
    @menu_button_label  = menu_button_label
    @navigation_classes = navigation_classes
    @navigation_label   = navigation_label
  end

private

  def default_classes
    %w(govuk-header)
  end

  def navigation_classes
    %w(govuk-header__navigation).tap { |nc|
      nc.concat(@navigation_classes.is_a?(String) ? @navigation_classes.split : @navigation_classes)
    }.uniq
  end

  class Item < GovukComponent::Slot
    attr_accessor :title, :href, :active

    def initialize(title:, href: nil, active: false, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      self.title  = title
      self.href   = href
      self.active = active
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
end
