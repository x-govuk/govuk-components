module Examples
  module StartButtonHelpers
    def start_button_normal
      <<~START_BUTTON
       = govuk_start_button(text: "Start now", href: "#")
      START_BUTTON
    end
  end
end
