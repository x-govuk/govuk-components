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
                                   navigation_items: navigation_items,
                                   navigation_id: 'example-2')
      SNIPPET
    end

    def service_navigation_with_a_current_page_data
      <<~DATA
        { navigation_items: [
          { text: "Footer",   href: "/components/footer" },
          { text: "Header",   href: "/components/header", current: true },
          { text: "Panel", href: "/components/panel" },
          { text: "Table", href: "/components/table" },
          { text: "Tag",  href: "/components/tag" }
        ] }
      DATA
    end

    def service_navigation_with_navigation_items
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service",
                                   current_path: "/components/panel",
                                   navigation_items: navigation_items,
                                   navigation_id: 'example-3')
      SNIPPET
    end

    def service_navigation_with_navigation_items_data
      <<~DATA
        { navigation_items: [
          { text: "Footer",   href: "/components/footer" },
          { text: "Header",   href: "/components/header" },
          { text: "Panel", href: "/components/panel" },
          { text: "Table",  href: "/components/table" },
          { text: "Tag",  href: "/components/tag" }
        ] }
      DATA
    end

    def service_navigation_with_matching_subpages
      <<~SNIPPET
        = govuk_service_navigation(service_name: "My new service",
                                   current_path: "/components/table/dining/extendable",
                                   navigation_items: navigation_items,
                                   navigation_id: 'example-4')
      SNIPPET
    end

    def service_navigation_with_matching_subpages_data
      <<~DATA
        { navigation_items: [
          { text: "Footer",   href: "/components/footer", active_when: "/components/footer" },
          { text: "Header",   href: "/components/header", active_when: "/components/header" },
          { text: "Panel", href: "/components/panel", active_when: "/components/panel" },
          { text: "Table",  href: "/components/table", active_when: "/components/table" },
          { text: "Tag",  href: "/components/tag", active_when: "/components/tag" }
        ] }
      DATA
    end

    def service_navigation_manual
      <<~SNIPPET
        = govuk_service_navigation(navigation_id: 'example-5', classes: 'app-service-navigation') do |sn|
          = sn.with_start_slot { '🌅' }
          = sn.with_service_name(service_name: 'A really great service', service_url: '#')
          = sn.with_navigation_item(text: "Footer", href: "/components/footer")
          = sn.with_navigation_item(text: "Header", href: "/components/header")
          = sn.with_navigation_item(text: "Panel", href: "/components/panel")
          = sn.with_navigation_item(text: "Table", href: "/components/table")
          = sn.with_navigation_item(text: "Tag", href: "/components/tag", active: true)
          = sn.with_end_slot { '🌆' }
      SNIPPET
    end
  end
end
