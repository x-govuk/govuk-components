module Examples
  module BackToTopLinkHelpers
    def govuk_back_to_top_link_with_custom_target
      %(= govuk_back_to_top_link("#top"))
    end
  end
end
