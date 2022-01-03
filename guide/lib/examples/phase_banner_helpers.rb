module Examples
  module PhaseBannerHelpers
    def phase_banner_normal
      <<~PHASE_BANNER
        = govuk_phase_banner(tag: { text: "Alpha" }, text: "This is a new service – your feedback will help us to improve it. ")
      PHASE_BANNER
    end

    def phase_banner_with_block
      <<~PHASE_BANNER
        = govuk_phase_banner(tag: { text: "Alpha" }) do
          | This is a new service, your

          = govuk_link_to("feedback", "#")

          | will help us improve it.
      PHASE_BANNER
    end

    def phase_banner_with_custom_tag_colour
      <<~PHASE_BANNER
        = govuk_phase_banner(tag: { text: "Warning", colour: "pink" }, text: "This is a test environment, don't enter any real data")
      PHASE_BANNER
    end
  end
end
