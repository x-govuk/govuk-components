module Examples
  module TagHelpers
    def tag_normal
      <<~TAG
        = govuk_tag(text: "Completed")
      TAG
    end

    def tag_colours
      <<~TAG
        - %w(Grey Green Turquoise Blue Light-blue Red Purple Pink Orange Yellow).each do |colour|
          = govuk_tag(text: colour, colour: colour.downcase)
      TAG
    end
  end
end
