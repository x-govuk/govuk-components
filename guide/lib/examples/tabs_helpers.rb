module Examples
  module TabsHelpers
    def tabs_normal
      <<~TABS
        = govuk_tabs do |tabs|
          - tabs.with_tab(label: "Text", text: "This was set using a text argument")
          - tabs.with_tab(label: "Inline block") { "This was set using an inline block of content" }
          - tabs.with_tab(label: "Regular block") do
            p This was set using a block of HTML.
            p Use this style if you need complex markup within your tab.
      TABS
    end
  end
end
