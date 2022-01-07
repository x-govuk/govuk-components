module Examples
  module HeaderHelpers
    def header_normal
      <<~HEADER
        = govuk_header
      HEADER
    end

    def header_with_custom_logo_and_service_name
      <<~HEADER
        = govuk_header(service_name: "Apply for a juggling licence") do |header|
          - header.custom_logo
            | 🤹 GOV.UK
      HEADER
    end

    def header_with_custom_logotype_and_homepage_url
      <<~HEADER
        = govuk_header(logotype: "Custom", homepage_url: "#")
      HEADER
    end

    def header_with_custom_product_name
      <<~HEADER
        = govuk_header do |header|
          - header.product_name(name: "Product")
      HEADER
    end

    def header_with_navigation_items
      <<~HEADER
        = govuk_header(service_name: "Apply for a juggling licence") do |header|
          - header.navigation_item(text: "Amateur juggling", href: "#", active: false)
          - header.navigation_item(text: "Professional juggling", href: "#", active: false)
          - header.navigation_item(text: "Dangerous juggling", href: "#", active: false)
      HEADER
    end
  end
end
