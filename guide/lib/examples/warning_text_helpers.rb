module Examples
  module WarningTextHelpers
    def warning_text_normal
      <<~WARNING_TEXT
        = dsfr_warning_text(text: "You can be fined up to £5,000 if you do not register.")
      WARNING_TEXT
    end

    def warning_text_with_custom_icon_fallback_text
      <<~WARNING_TEXT
        = dsfr_warning_text(icon_fallback_text: "Danger") do
          | You can be fined up to £5,000 if you do not register.
      WARNING_TEXT
    end
  end
end
