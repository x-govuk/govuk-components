class GovukComponent::SummaryListComponent::CardComponent < GovukComponent::Base
  attr_reader :title

  renders_many :actions
  renders_one :summary_list, "GovukComponent::SummaryListComponent"

  def initialize(title:, actions: [], classes: [], html_attributes: {})
    @title = title
    actions.each { |a| with_action { a } } if actions.any?

    super(classes: classes, html_attributes: html_attributes)
  end

private

  def default_attributes
    { class: "#{brand}-summary-card" }
  end
end
