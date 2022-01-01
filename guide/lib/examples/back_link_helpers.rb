module Examples
  module BackLinkHelpers
    def back_link_normal
      <<~BACK_LINK_NORMAL
        = govuk_back_link(href: "/")
      BACK_LINK_NORMAL
    end

    def back_link_custom
      <<~BACK_LINK_NORMAL
        = govuk_back_link(href: "/", text: "Return", classes: "hide-in-print")
      BACK_LINK_NORMAL
    end
  end
end
