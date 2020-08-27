class GovukComponent::Header < GovukComponent::Base
  include ViewComponent::Slotable

  attr_accessor :logo, :logo_href, :service_name, :service_name_href

  with_slot :item, collection: true, class_name: 'Item'

  def initialize(logo: 'GOV.UK', logo_href: '/', service_name: nil, service_name_href: '/', classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @logo              = logo
    @logo_href         = logo_href
    @service_name      = service_name
    @service_name_href = service_name_href
  end

private

  def default_classes
    %w(govuk-header)
  end

  class Item < GovukComponent::Slot
    attr_accessor :title, :href, :active

    def initialize(title:, href:, active: false, classes: [], html_attributes: {})
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

  private

    def default_classes
      %w(govuk-header__navigation-item)
    end
  end
end
