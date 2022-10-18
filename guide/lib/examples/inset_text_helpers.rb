module Examples
  module InsetTextHelpers
    def inset_text_normal
      <<~INSET_TEXT
        = dsfr_inset_text(text: "One line of inset text")
      INSET_TEXT
    end

    def inset_text_block
      <<~INSET_TEXT
        = dsfr_inset_text do
          p
            | Multiple lines of inset text

          ul
            li one
            li two
            li three
      INSET_TEXT
    end
  end
end
