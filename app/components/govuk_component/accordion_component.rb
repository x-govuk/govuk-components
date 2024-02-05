class GovukComponent::AccordionComponent < GovukComponent::Base
  renders_many :sections, ->(heading_text: nil, summary_text: nil, expanded: false, classes: [], html_attributes: {}, &block) do
    GovukComponent::AccordionComponent::SectionComponent.new(
      classes:,
      expanded:,
      heading_level:, # set once at parent level, passed to all children
      html_attributes:,
      summary_text:,
      heading_text:,
      accordion_id:,
      &block
    )
  end

  attr_reader :accordion_id, :heading_level

  def initialize(heading_level: 2, classes: [], html_attributes: {})
    @heading_level = heading_tag(heading_level)
    @accordion_id  = html_attributes[:id]

    super(classes:, html_attributes:)
  end

  def call
    tag.div(**html_attributes) { safe_join(sections) }
  end

private

  def default_attributes
    { class: "#{brand}-accordion", data: { module: "#{brand}-accordion" } }.compact
  end

  def heading_tag(level)
    fail(ArgumentError, "heading_level must be 1-6") unless level.in?(1..6)

    %(h#{level})
  end
end
