class GovukComponent::AccordionComponent::SectionComponent < GovukComponent::Base
  attr_reader :heading_text, :summary_text, :expanded, :heading_level, :accordion_id

  renders_one :heading_html
  renders_one :summary_html

  alias_method :expanded?, :expanded

  def initialize(heading_text:, summary_text:, expanded:, heading_level:, accordion_id: nil, classes: [], html_attributes: {})
    @heading_text  = heading_text
    @summary_text  = summary_text
    @expanded      = expanded
    @heading_level = heading_level
    @accordion_id  = accordion_id

    super(classes:, html_attributes:)
  end

  def id(suffix: nil)
    prefix = @accordion_id

    # generate a random number if we don't have heading_text to avoid attempting
    # to parameterize a potentially-huge chunk of HTML
    @unique_identifier ||= heading_text&.parameterize || SecureRandom.hex(4)

    [prefix, @unique_identifier, suffix].compact.join('-')
  end

  def heading_content
    heading_html || heading_text || fail(ArgumentError, "no heading_text or heading_html")
  end

  def summary_content
    summary_html || summary_text
  end

private

  def default_attributes
    { class: class_names("#{brand}-accordion__section", "#{brand}-accordion__section--expanded" => expanded?).split }
  end
end
