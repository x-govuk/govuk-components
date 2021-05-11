class GovukComponent::SummaryList < GovukComponent::Base
  renders_many :rows, "Row"
  wrap_slot :row

  def any_row_has_actions?
    rows.any? { |r| r.action.present? }
  end

private

  def default_classes
    %w(govuk-summary-list)
  end

  class Row < GovukComponent::Base
    attr_accessor :key, :value, :action

    def initialize(key:, value:, action: nil, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      self.key    = key
      self.value  = value
      self.action = action
    end

  private

    def default_classes
      %w(govuk-summary-list__row)
    end
  end
end
