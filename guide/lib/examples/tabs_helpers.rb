module Examples
  module TabsHelpers
    def tabs_normal
      <<~TABS
        = dsfr_tabs(title: "Monday’s child nursery rhyme") do |c|
          - c.tab(label: "Monday", text: "Monday’s child is fair of face")
          - c.tab(label: "Tuesday", text: "Tuesday’s child is full of grace")
          - c.tab(label: "Wednesday")
            | Wednesday’s child is full of woe
      TABS
    end
  end
end
