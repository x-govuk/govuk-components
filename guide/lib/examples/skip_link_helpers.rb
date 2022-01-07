module Examples
  module SkipLinkHelpers
    def skip_link_normal
      <<~SKIP_LINK
        #{skip_link_instructions}

        = govuk_skip_link
      SKIP_LINK
    end

    def skip_link_with_custom_href_and_text
      <<~SKIP_LINK
        #{skip_link_instructions}

        = govuk_skip_link(href: "#some-other-id", text: "Jump to the important bits")
      SKIP_LINK
    end

  private

    def skip_link_instructions
      "p To view the skip link component, tab to this example --- or click inside this example and press tab."
    end
  end
end
