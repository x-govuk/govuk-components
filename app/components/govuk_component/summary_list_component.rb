module GovukComponent
  class SummaryListComponent < GovukComponent::Base
    attr_reader :borders, :actions, :card

    renders_many :rows, ->(classes: [], html_attributes: {}, &block) do
      GovukComponent::SummaryListComponent::RowComponent.new(
        show_actions_column: @show_actions_column,
        card_title: card&.title,
        classes: classes,
        html_attributes: html_attributes,
        &block
      )
    end

    def initialize(rows: nil, actions: true, borders: config.default_summary_list_borders, card: nil, classes: [], html_attributes: {})
      @borders             = borders
      @show_actions_column = actions
      @card                = GovukComponent::SummaryListComponent::CardComponent.new(**card) unless card.blank?

      super(classes: classes, html_attributes: html_attributes)

      return unless rows.presence

      build(rows)
    end

    def call
      summary_list = tag.dl(**html_attributes) { safe_join(rows) }

      (card?) ? card_with(summary_list) : summary_list
    end

  private

    def card?
      @card.present?
    end

    # we're not using `renders_one` here because we always want the card to render
    # outside of the summary list. when manually building use
    # govuk_summary_list_card { govuk_summary_list }
    def card_with(summary_list)
      render(@card) { summary_list }
    end

    def borders_class
      "#{brand}-summary-list--no-border" unless borders
    end

    def default_attributes
      { class: ["#{brand}-summary-list", borders_class].compact }
    end

    def build(rows)
      @show_actions_column &&= rows.any? { |r| r.key?(:actions) }

      rows.each do |data|
        k, v, a = data.values_at(:key, :value, :actions)

        with_row(**data.slice(:classes, :html_attributes)) do |r|
          r.with_key(**k)
          r.with_value(**v)
          Array.wrap(a).each { |ad| r.with_action(**ad) }
        end
      end
    end
  end
end
