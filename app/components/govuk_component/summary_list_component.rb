class GovukComponent::SummaryListComponent < GovukComponent::Base
  attr_reader :borders

  renders_many :rows, "Row"

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

  class Row < GovukComponent::Base
    attr_reader :key, :value, :href, :text, :visually_hidden_text, :action_classes, :action_attributes

    def initialize(key:, value:, action: {}, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @key   = key
      @value = value

      if action.present?
        @href                 = action[:href]
        @text                 = action[:text] || "Change"
        @visually_hidden_text = " #{action[:visually_hidden_text] || key.downcase}"
        @action_classes       = action[:classes] || []
        @action_attributes    = action[:html_attributes] || {}
      end
    end

    def action
      tag.dd(class: "govuk-summary-list__actions") do
        if href.present?
          govuk_link_to(href, class: action_classes, **action_attributes) do
            safe_join([text, tag.span(visually_hidden_text, class: "govuk-visually-hidden")])
          end
        end
      end
    end

  private

    def default_classes
      %w(govuk-summary-list__row)
    end
  end
end
