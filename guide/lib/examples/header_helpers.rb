module Examples
  module HeaderHelpers
    def header_normal
      <<~HEADER
        = govuk_header(homepage_url: "https://www.gov.uk")
      HEADER
    end

    def header_with_service_name
      <<~HEADER
        = govuk_header(homepage_url: "https://www.gov.uk", service_name: "Apply for a juggling licence", service_url: "#")
      HEADER
    end

    def header_with_custom_logo_and_service_name
      <<~HEADER
        = govuk_header(homepage_url: "#", service_name: "Apply for a juggling licence", service_url: "#") do |header|
          - header.with_custom_logo
            svg focusable="false" role="img" class="app-header__logotype" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 30" height="30" width="40"
              path d="M18,4 L36,30 0,30 18,4"
            span.app-header__logotext MyOrg
      HEADER
    end

    def header_with_custom_product_name
      <<~HEADER
        = govuk_header(homepage_url: "#") do |header|
          - header.with_product_name(name: "Product")
      HEADER
    end

    def header_with_navigation_items
      <<~HEADER
        = govuk_header(homepage_url: "https://www.gov.uk", service_name: "Apply for a juggling licence", service_url: "#") do |header|
          - header.with_navigation_item(text: "Amateur juggling", href: "#", active: false)
          - header.with_navigation_item(text: "Professional juggling", href: "#", active: false)
          - header.with_navigation_item(text: "Dangerous juggling", href: "#", active: false)
      HEADER
    end
  end
end
