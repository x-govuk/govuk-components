module GovukComponent
  class SummaryListComponent < GovukComponent::Base
    attr_reader :borders

    renders_many :rows, "GovukComponent::SummaryListComponent::RowComponent"

    def initialize(borders: true, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @borders = borders
    end

    def any_row_has_actions?
      rows.any? { |row| row.href.present? }
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
