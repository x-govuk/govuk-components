module Examples
  module SectionBreakHelpers
    def section_break_visible
      <<~SECTION_BREAK
        = govuk_section_break(visible: true)
      SECTION_BREAK
    end

    def section_break_visible_xl
      <<~SECTION_BREAK
        = govuk_section_break(visible:true, size: "xl")
      SECTION_BREAK
    end
  end
end
