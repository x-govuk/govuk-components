module Examples
  module ServiceNavigationHelpers
    def service_navigation_with_only_service_name
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service")
      SNIPPET
    end

    def service_navigation_with_navigation_items
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service",
                                   navigation_items: [ { text: "One" }, { text: "Two" } ])
      SNIPPET
    end
  end
end
