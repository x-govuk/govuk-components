module Examples
  module FeedbackHelpers
    def govuk_feedback_minimal
      <<~FEEDBACK_MINIMAL
        = govuk_feedback(title_text: "Help us improve this service",
                         heading_level: 3,
                         text: %(<a href="#" class="govuk-link">Email us</a> to let us know what you think.))
      FEEDBACK_MINIMAL
    end

    def govuk_feedback_with_slots
      <<~FEEDBACK_WITH_SLOTS
        = govuk_feedback do |component|
          - component.with_header { "Tell us how we're doing" }
          - component.with_body do
            ' You can send us feedback by:

            ul.govuk-list
              li
                a href="#" class="govuk-link"
                  | email
              li
                a href="#" class="govuk-link"
                  | text message
              li
                a href="#" class="govuk-link"
                  | post
      FEEDBACK_WITH_SLOTS
    end
  end
end
