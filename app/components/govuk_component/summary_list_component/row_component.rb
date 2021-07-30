class GovukComponent::SummaryListComponent::RowComponent < GovukComponent::Base
  attr_reader :href, :text, :visually_hidden_text

  renders_one :key, GovukComponent::SummaryListComponent::KeyComponent
  renders_one :value, GovukComponent::SummaryListComponent::ValueComponent
  renders_many :actions, GovukComponent::SummaryListComponent::ActionComponent

  def initialize(classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(class: classes, **html_attributes) do
      safe_join([key, value, actions_content])
    end
  end

private

  def actions_content
    return if actions.blank?

    (actions.one?) ? single_action : actions_list
  end

  def single_action
    tag.dd(class: actions_class) { safe_join(actions) }
  end

  def actions_list
    tag.dd(class: actions_class) do
      tag.ul(class: "govuk-summary-list__actions-list") do
        safe_join(actions.map { |action| tag.li(action, class: "govuk-summary-list__actions-list-item") })
      end
    end
  end

  def default_classes
    %w(govuk-summary-list__row)
  end

  def actions_class
    "govuk-summary-list__actions"
  end
end
