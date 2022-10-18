module Examples
  module AccordionHelpers
    def accordion_normal
      <<~ACCORDION
        = dsfr_accordion do |accordion|
          - accordion.section(heading_text: "One") { tag.p("One content") }

          - accordion.section(heading_text: "Two") { tag.p("Two content") }

          - accordion.section(heading_text: "Three", expanded: true) { tag.p("Three content") }
      ACCORDION
    end

    def accordion_with_section_summaries
      <<~ACCORDION
        = dsfr_accordion do |accordion|
          - accordion.section(heading_text: "First",
                              summary_text: "First summary") { tag.p("First content") }

          - accordion.section(heading_text: "Second",
                              summary_text: "Second summary") { tag.p("Second content") }
      ACCORDION
    end
  end
end
