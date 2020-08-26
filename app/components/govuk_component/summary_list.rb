class GovukComponent::SummaryList < GovukComponent::Base
  include ViewComponent::Slotable

  with_slot :row, collection: true, class_name: 'Row'

  def any_row_has_actions?
    rows.any? { |r| r.action.present? }
  end

private

  def default_classes
    %w(govuk-summary-list)
  end

  class Row < GovukComponent::Slot
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
