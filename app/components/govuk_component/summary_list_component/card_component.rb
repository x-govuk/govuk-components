class GovukComponent::SummaryListComponent::CardComponent < GovukComponent::Base
  attr_reader :title, :heading_level

  renders_many :actions
  renders_one :summary_list, "GovukComponent::SummaryListComponent"

  def initialize(title:, heading_level: 2, actions: [], classes: [], html_attributes: {})
    @title = title
    @heading_level = heading_level
    actions.each { |a| with_action { a } } if actions.any?

    super(classes:, html_attributes:)
  end

private

  def default_attributes
    { class: "#{brand}-summary-card" }
  end

  def heading_tag
    "h#{heading_level}"
  end

  def action_text(action)
    safe_join([action, tag.span(" (" + title + ")", class: "#{brand}-visually-hidden")])
  end
end
