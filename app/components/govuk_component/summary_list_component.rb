module GovukComponent
  class SummaryListComponent < GovukComponent::Base
    attr_reader :borders, :actions, :card

    renders_many :rows, ->(html_attributes: {}, &block) do
      GovukComponent::SummaryListComponent::RowComponent.new(
        show_actions_column: @show_actions_column,
        html_attributes: html_attributes,
        &block
      )
    end

    def initialize(rows: nil, actions: true, borders: config.default_summary_list_borders, card: nil, html_attributes: {})
      @borders             = borders
      @show_actions_column = actions
      @card                = card

      super(html_attributes: html_attributes)

      return unless rows.presence

      build(rows)
    end

    def call
      summary_list = tag.dl(**html_attributes) { safe_join(rows) }

      (card.nil?) ? summary_list : card_with(summary_list)
    end

  private

    # we're not using `renders_one` here because we always want the card to render
    # outside of the summary list. when manually building use
    # govuk_summary_list_card { govuk_summary_list }
    def card_with(summary_list)
      render(GovukComponent::SummaryListComponent::CardComponent.new(**card)) { summary_list }
    end

    def borders_class
      %(govuk-summary-list--no-border) unless borders
    end

    def default_attributes
      { class: ["govuk-summary-list", borders_class].compact }
    end

    def build(rows)
      @show_actions_column = rows.any? { |r| r.key?(:actions) }

      rows.each do |data|
        k, v, a = data.values_at(:key, :value, :actions)

        with_row(**data.slice(:html_attributes)) do |r|
          r.with_key(**k)
          r.with_value(**v)
          Array.wrap(a).each { |ad| r.with_action(**ad) }
        end
      end
    end
  end
end
