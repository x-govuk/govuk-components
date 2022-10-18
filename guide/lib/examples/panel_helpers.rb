module Examples
  module PanelHelpers
    def panel_normal
      <<~PANEL
        = dsfr_panel(title_text: "Application complete",
                      text: "You will soon receive an email confirmation.")
      PANEL
    end

    def panel_with_block
      <<~PANEL
        = dsfr_panel(title_text: "Application complete") do

          | Your reference number is

          br

          strong ABC123
      PANEL
    end
  end
end
