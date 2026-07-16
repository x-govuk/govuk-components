module Examples
  module PanelHelpers
    def panel_normal
      <<~PANEL
        = govuk_panel(title_text: "Application complete",
                      text: "You will soon receive an email confirmation.")
      PANEL
    end

    def panel_with_block
      <<~PANEL
        = govuk_panel(title_text: "Application complete") do

          | Your reference number is

          br

          strong ABC123
      PANEL
    end

    def interruption_panel
      <<~PANEL
        = govuk_panel(title_text: "Is your height correct?", interruption: true) do |panel|
          p.govuk-body
            | You entered your height as
            strong< 9m
            | .

          - panel.with_action(text: "Yes, this is correct", href: "#")
          - panel.with_action(text: "No, change my height", href: "#", type: :link)
      PANEL
    end
  end
end
