module DsfrComponent
  class SummaryListComponent < DsfrComponent::Base
    attr_reader :borders, :actions

    renders_many :rows, ->(classes: [], html_attributes: {}, &block) do
      DsfrComponent::SummaryListComponent::RowComponent.new(
        show_actions_column: @show_actions_column,
        classes: classes,
        html_attributes: html_attributes,
        &block
      )
    end

    def initialize(rows: nil, actions: true, borders: config.default_summary_list_borders, classes: [], html_attributes: {})
      @borders             = borders
      @show_actions_column = actions

      super(classes: classes, html_attributes: html_attributes)

      return unless rows.presence

      build(rows)
    end

  private

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

        row(**data.slice(:classes, :html_attributes)) do |r|
          r.key(**k)
          r.value(**v)
          Array.wrap(a).each { |ad| r.action(**ad) }
        end
      end
    end
  end
end
