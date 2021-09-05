class CookieBannerComponentPreview < ViewComponent::Preview
  include DummyLinks
  include GovukLinkHelper

  # @label Cookie banner
  #
  # Allow users to accept or reject cookies which are not essential to making
  # your service work.
  def cookie_banner
    render GovukComponent::CookieBannerComponent.new do |cookie_banner|
      cookie_banner.message(heading_text: "Cookies on imaginary service", text: "We use some essential cookies to make this service work.") do |message|
        message.action { govuk_button_link_to("Accept", "#") }
        message.action { govuk_button_link_to("Reject", "#", warning: true) }
        message.action { govuk_link_to("View cookies", "#") }
      end
    end
  end

  # @label Cookie banner without header
  #
  # The cookie banner component can also be used as a confirmation message once a user
  # has accepted or rejected cookies.
  def cookie_banner_without_header
    render GovukComponent::CookieBannerComponent.new do |cookie_banner|
      cookie_banner.message(text: "You’ve accepted additional cookies. You can change your cookie settings at any time.") do |message|
        message.action { govuk_button_link_to("Hide this message", "#") }
      end
    end
  end

  # @label Cookie banner with multiple paragraphs
  #
  # Any amount of required HTML can be added to a message via its block.
  def cookie_banner_with_multiple_paragraphs
    render GovukComponent::CookieBannerComponent.new do |cookie_banner|
      cookie_banner.message do |message|
        message.heading_html do
          tag.span("Cookies on imaginary service")
        end

        message.action { govuk_button_link_to("Accept", "#") }
        message.action { govuk_link_to("View cookies", "#") }

        safe_join([
          tag.p("We use some essential cookies to make this service work."),
          tag.p("We’d also like to use analytics cookies so we can understand how you use the service and make improvements.")
        ])
      end
    end
  end

  # @label Cookie banner with custom classes and HTML attributes
  #
  # Any custom classes and HTML attributes can be passed into both the banner and the individual messages.
  def cookie_banner_with_custom_classes_and_html_attributes
    render GovukComponent::CookieBannerComponent.new(classes: "large-cookie-banner", html_attributes: { data: { action: 'show-cookie-banner' }}) do |cookie_banner|
      cookie_banner.message(heading_text: "Cookies", text: "We use some essential cookies to make this service work.", classes: %w(flashing), html_attributes: { data: { action: 'accept-all-cookies' } }) do |message|
        message.action { govuk_button_link_to("Accept", "#") }
      end
    end
  end
end
