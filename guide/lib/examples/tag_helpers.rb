module Examples
  module TagHelpers
    def tag_normal
      <<~TAG
        = govuk_tag(text: "Completed")
      TAG
    end

    def tag_colours
      <<~TAG
        - %w(grey green turquoise blue red purple pink orange yellow).each do |colour|
          = govuk_tag(text: colour, colour: colour)
      TAG
    end
  end
end
