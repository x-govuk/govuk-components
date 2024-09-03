module Examples
  module ServiceNavigationHelpers
    def service_navigation_with_only_service_name
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service", service_url: "#")
      SNIPPET
    end

    def service_navigation_with_a_current_page
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service",
                                   navigation_items: navigation_items)
      SNIPPET
    end

    def service_navigation_with_a_current_page_data
      <<~DATA
        { navigation_items: [
          { text: "Footer",   href: "/components/footer" },
          { text: "Header",   href: "/components/header", current: true },
          { text: "Panel", href: "/components/panel" },
          { text: "Table", href: "/components/table" }
        ] }
      DATA
    end

    def service_navigation_with_navigation_items
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service",
                                   current_path: "/components/panel",
                                   navigation_items: navigation_items)
      SNIPPET
    end

    def service_navigation_with_navigation_items_data
      <<~DATA
        { navigation_items: [
          { text: "Footer",   href: "/components/footer" },
          { text: "Header",   href: "/components/header" },
          { text: "Panel", href: "/components/panel" },
          { text: "Table",  href: "/components/table" }
        ] }
      DATA
    end

    def service_navigation_with_matching_subpages
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service",
                                   current_path: "/components/table/dining/extendable",
                                   navigation_items: navigation_items)
      SNIPPET
    end

    def service_navigation_with_matching_subpages_data
      <<~DATA
        { navigation_items: [
          { text: "Footer",   href: "/components/footer", active_when: "/components/footer" },
          { text: "Header",   href: "/components/header", active_when: "/components/header" },
          { text: "Panel", href: "/components/panel", active_when: "/components/panel" },
          { text: "Table",  href: "/components/table", active_when: "/components/table" }
        ] }
      DATA
    end
  end
end
