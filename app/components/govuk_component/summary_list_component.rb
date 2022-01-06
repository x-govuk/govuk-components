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

    def initialize(actions: true, borders: true, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @borders             = borders
      @show_actions_column = actions
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
  end
end
