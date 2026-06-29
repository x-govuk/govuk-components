module Examples
  module GenericHeaderHelpers
    def generic_header_with_logo_text_and_url
      <<~GENERIC_HEADER
        = govuk_generic_header(logo_text: 'A generic service', url: '/')
      GENERIC_HEADER
    end

    def generic_header_with_custom_logo
      <<~GENERIC_HEADER
        = govuk_generic_header do |header|
          - header.with_logo do
            a href='/' class='govuk-generic-header__homepage-link'
              | 🩵 My generic service
      GENERIC_HEADER
    end

    def generic_header_with_custom_content
      <<~GENERIC_HEADER
        = govuk_generic_header(logo_text: 'A generic service', url: '/', html_attributes: { class: 'with-username' }) do
          | Sign out
      GENERIC_HEADER
    end

    def generic_header_with_service_navigation_and_phase_banner
      <<~GENERIC_HEADER
        = govuk_generic_header(logo_text: 'Some organisation', url: '/') do |header|
          - header.with_service_navigation(service_name: 'Service navigation', service_url: '#')
          - header.with_phase_banner(tag: { text: "Beta" }, text: "This is a generic service")
      GENERIC_HEADER
    end
  end
end
