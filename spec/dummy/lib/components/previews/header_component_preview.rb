class HeaderComponentPreview < ViewComponent::Preview
  include DummyLinks
  include GovukLinkHelper

  # @label Header
  #
  # The GOV.UK header shows users that they are on GOV.UK and which service they are using.
  def header
    render GovukComponent::HeaderComponent.new
  end

  # @label Header with custom logotype
  def header_with_custom_logotype
    render GovukComponent::HeaderComponent.new(logotype: "Custom")
  end

  # @label Header with a service name
  def header_with_a_service_name
    render GovukComponent::HeaderComponent.new(service_name: "Apply for a juggling licence")
  end

  # @label Header with the crown hidden
  def header_with_the_crown_logo_hidden
    render GovukComponent::HeaderComponent.new(crown: false)
  end

  # @label Header with navigation options
  def header_with_navigation_items
    render GovukComponent::HeaderComponent.new do |header|
      header.navigation_item(text: 'Page A', href: '/#page-a', active: true)
      header.navigation_item(text: 'Page B', href: '/#page-b')
      header.navigation_item(text: 'Page C', href: '/#page-c')
    end
  end

  # @label Header with custom menu button ARIA label
  def header_with_custom_menu_button_text
    render GovukComponent::HeaderComponent.new(menu_button_label: "Options") do |header|
      header.navigation_item(text: 'Page A', href: '/#page-a', active: true)
      header.navigation_item(text: 'Page B', href: '/#page-b')
      header.navigation_item(text: 'Page C', href: '/#page-c')
    end
  end

  # @label Header with custom logo
  #
  # For an entirely custom header the custom_logo slot can be used. It will suppress all other
  # logo contents
  def header_with_custom_logo
    render GovukComponent::HeaderComponent.new do |header|
      header.custom_logo do
        tag.span("👑 DfE Digital")
      end
    end
  end
end
