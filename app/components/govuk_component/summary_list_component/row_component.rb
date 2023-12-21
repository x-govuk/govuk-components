class GovukComponent::SummaryListComponent::RowComponent < GovukComponent::Base
  attr_reader :href, :visually_hidden_text, :show_actions_column, :visually_hidden_action_suffix

  renders_one :key, GovukComponent::SummaryListComponent::KeyComponent
  renders_one :value, GovukComponent::SummaryListComponent::ValueComponent
  renders_many :actions, ->(href: nil, text: 'Change', visually_hidden_text: false, classes: [], html_attributes: {}, &block) do
    GovukComponent::SummaryListComponent::ActionComponent.new(
      href: href,
      text: text,
      visually_hidden_text: visually_hidden_text,
      visually_hidden_action_suffix: visually_hidden_action_suffix,
      classes: classes,
      html_attributes: html_attributes,
      &block
    )
  end

  def initialize(show_actions_column: nil, visually_hidden_action_suffix: nil, classes: [], html_attributes: {})
    @show_actions_column = show_actions_column
    @visually_hidden_action_suffix = visually_hidden_action_suffix

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
      tag.ul(class: "#{brand}-summary-list__actions-list") do
        safe_join(actions.map { |action| tag.li(action, class: "#{brand}-summary-list__actions-list-item") })
      end
    end
  end

  def default_attributes
    { class: "#{brand}-summary-list__row" }
  end

  def actions_class
    "#{brand}-summary-list__actions"
  end

  def no_actions_class
    "#{brand}-summary-list__row--no-actions"
  end
end
