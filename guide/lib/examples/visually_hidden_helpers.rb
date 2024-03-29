module Examples
  module VisuallyHiddenHelpers
    def visually_hidden_text_via_argument
      <<~SNIPPET
        p Regular text

        = govuk_visually_hidden("This content is visually hidden")

        p More regular text
      SNIPPET
    end

    def visually_hidden_text_via_block
      <<~SNIPPET
        p Regular text

        = govuk_visually_hidden do
          p This paragraph is visually hidden

        p More regular text
      SNIPPET
    end
  end
end
