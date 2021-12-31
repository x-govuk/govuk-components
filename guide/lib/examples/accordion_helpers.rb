module Examples
  module AccordionHelpers
    def accordion_normal
      <<~ACCORDION
        = govuk_accordion do |accordion|
          - accordion.section(heading_text: "First section") { tag.p("First section content") }
          - accordion.section(heading_text: "Second section") { tag.p("Second section content") }
          - accordion.section(heading_text: "Third section") { tag.p("Third section content") }
      ACCORDION
    end

    def accordion_with_section_summaries
      <<~ACCORDION
        = govuk_accordion do |accordion|
          - accordion.section(heading_text: "First section with summary", summary_text: "First section summary") { tag.p("First section content") }
          - accordion.section(heading_text: "Second section with summary", summary_text: "Second section summary") { tag.p("Second section content") }
          - accordion.section(heading_text: "Third section with summary", summary_text: "Third section summary") { tag.p("Third section content") }
      ACCORDION
    end

    def accordion_custom
      <<~ACCORDION
        = govuk_accordion(id: "accordion-custom", heading_level: 4) do |accordion|

          - accordion.section(heading_text: "First custom section",
                              expanded: true, 
                              classes: "important") { tag.p("First section content") }

          - accordion.section(heading_text: "Second custom section",
                              expanded: true) { tag.p("Second section content") }

          - accordion.section(heading_text: "Third custom section",
                              expanded: true, 
                              classes: "important") { tag.p("Third section content") }
      ACCORDION
    end
  end
end
