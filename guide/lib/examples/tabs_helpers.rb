module Examples
  module TabsHelpers
    def tabs_normal
      <<~TABS
        = govuk_tabs(title: "Contents") do |tabs|
          - tabs.with_tab(label: "Monday")
            | Monday’s child is fair of face
          - tabs.with_tab(label: "Tuesday")
            | Tuesday’s child is full of grace
          - tabs.with_tab(label: "Wednesday", text: "Wednesday’s child is full of woe")
      TABS
    end
  end
end
