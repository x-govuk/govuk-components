module Examples
  module ListHelpers
    def govuk_list_plain
      <<~EXAMPLE
        = govuk_list [govuk_link_to("News", "#"), govuk_link_to("Publications", "#")]
      EXAMPLE
    end

    def govuk_list_bullet
      <<~EXAMPLE
        = govuk_list ["apples", "oranges", "pears"], type: :bullet
      EXAMPLE
    end

    def govuk_list_number
      <<~EXAMPLE
        = govuk_list ["Delivery address.", "Payment.", "Confirmation."], type: :number
      EXAMPLE
    end

    def govuk_list_spaced
      <<~EXAMPLE
        = tag.p "You will have to apply the reverse charge if you supply any of these services:"
        = govuk_list type: :bullet, spaced: true do
          = tag.li "constructing, altering, repairing, extending, demolishing or dismantling buildings or structures (whether permanent or not), including offshore installation services"
          = tag.li "pipelines, reservoirs, water mains, wells, sewers, industrial plant and installations for purposes of land drainage, coast protection or defence"
      EXAMPLE
    end
  end
end
