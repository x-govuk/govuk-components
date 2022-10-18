class DsfrComponent::SummaryListComponent::RowComponent < DsfrComponent::Base
  attr_reader :href, :visually_hidden_text, :show_actions_column

  renders_one :key, DsfrComponent::SummaryListComponent::KeyComponent
  renders_one :value, DsfrComponent::SummaryListComponent::ValueComponent
  renders_many :actions, DsfrComponent::SummaryListComponent::ActionComponent

  def initialize(show_actions_column: nil, classes: [], html_attributes: {})
    @show_actions_column = show_actions_column

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(**html_attributes) do
      safe_join([key, value, actions_content])
    end
  end

  def before_render
    if show_actions_column && actions.none?
      html_attributes[:class] << no_actions_class
    end
  end

private

  def actions_content
    return unless show_actions_column && actions.any?

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

  def default_attributes
    { class: %w(govuk-summary-list__row) }
  end

  def actions_class
    "govuk-summary-list__actions"
  end

  def no_actions_class
    "govuk-summary-list__row--no-actions"
  end
end
