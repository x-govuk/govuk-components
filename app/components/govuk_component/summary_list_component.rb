module GovukComponent
  class SummaryListComponent < GovukComponent::Base
    attr_reader :borders, :actions

    renders_many :rows, ->(classes: [], html_attributes: {}, &block) do
      GovukComponent::SummaryListComponent::RowComponent.new(
        show_actions_column: @show_actions_column,
        classes: classes,
        html_attributes: html_attributes,
        &block
      )
    end

    def initialize(rows: nil, actions: true, borders: true, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @borders             = borders
      @show_actions_column = actions

      return unless rows.presence

      build(rows)
    end

    def classes
      super.append(borders_class).compact
    end

  private

    def borders_class
      %(govuk-summary-list--no-border) unless borders
    end

    def default_classes
      %w(govuk-summary-list)
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
