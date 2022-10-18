module Examples
  module CommonOptionsHelpers
    def inset_text_with_classes
      <<~LINK
        = dsfr_inset_text(classes: "govuk-!-font-weight-bold")
          | Some strong text
      LINK
    end

    def inset_text_with_html_attributes
      <<~LINK
        = dsfr_inset_text(html_attributes: { lang: "en-GB",
                                              data: { demo: true },
                                              aria: { role: 'note' } })
          | Text with custom HTML attributes
      LINK
    end
  end
end
