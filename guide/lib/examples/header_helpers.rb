module Examples
  module HeaderHelpers
    def header_normal
      <<~HEADER
        = govuk_header
      HEADER
    end

    def header_with_custom_logo
      <<~HEADER
        = govuk_header do |header|
          - header.with_custom_logo
            svg focusable="false" role="img" class="app-header__logotype" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 30" height="30" width="40"
              path d="M18,4 L36,30 0,30 18,4"
            span.app-header__logotext MyOrg
      HEADER
    end

    def header_with_custom_product_name
      <<~HEADER
        = govuk_header do |header|
          - header.with_product_name(name: "Product")
      HEADER
    end

    def header_with_service_nav_and_phase_banner
      <<~HEADER
        = govuk_header do |header|
          - header.with_service_navigation(service_name: "My fancy service",
                                           service_url: "#",
                                           navigation_items: navigation_items)
          - header.with_phase_banner(tag: { text: 'Alpha' },
                                     text: "This is a new service. Be nice")
      HEADER
    end

    def header_with_service_nav_and_phase_banner_data
      <<~NAV_DATA
        {
          navigation_items: [
            { text: "Page one", href: "#page-one", current: true },
            { text: "Page two", href: "#page-two" },
            { text: "Page three", href: "#page-three" },
          ]
        }
      NAV_DATA
    end

    def header_with_extra_content
      <<~HEADER
        = govuk_header(classes: %w(with-extra-content)) do
          .govuk-header__container.account-options
            = govuk_link_to('#', inverse: true, no_underline: true)
              | Sign in
      HEADER
    end
  end
end
