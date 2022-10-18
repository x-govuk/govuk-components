module Examples
  module DetailsHelpers
    def details_normal
      <<~DETAILS
        = dsfr_details(summary_text: summary_text, text: text)
      DETAILS
    end

    def details_normal_arguments
      <<~DETAILS_DATA
        {
          summary_text: "Help with nationality",
          text: "We need to know your nationality so we can work out which elections you can vote in."
        }
      DETAILS_DATA
    end

    def details_with_block
      <<~DETAILS
        = dsfr_details(summary_text: "Help with nationality") do
          p
            | We need to know your nationality so we can work out which elections
              you’re entitled to vote in.

          p
            | If you cannot provide your nationality, you’ll have to send copies of
              identity documents through the post.
      DETAILS
    end

    def details_open
      <<~DETAILS
        = dsfr_details(summary_text: summary_text, text: text, open: true)
      DETAILS
    end
  end
end
