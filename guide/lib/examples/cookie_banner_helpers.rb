module Examples
  module CookieBannerHelpers
    def cookie_banner_normal
      <<~COOKIE_BANNER
        = govuk_cookie_banner do |cb|
          - cb.with_message(heading_text: "Cookies on this service") do |m|
            - m.with_action { govuk_button_link_to("Accept additional cookies", "#") }
            - m.with_action { govuk_button_link_to("Reject additional cookies", "#") }
            - m.with_action { govuk_link_to("Read the cookie policy", "#") }

            p
              | We use some essential cookies to make this service work.

            p
              | We’d also like to use analytics cookies so we can understand
                how you use the service and make improvements.
      COOKIE_BANNER
    end
  end
end
