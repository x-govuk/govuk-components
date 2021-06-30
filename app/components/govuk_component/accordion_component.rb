class GovukComponent::AccordionComponent < GovukComponent::Base
  renders_many :sections, "Section"

  attr_reader :id, :heading_level

  def initialize(id: nil, heading_level: 2, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id
    @heading_level = heading_tag(heading_level)
  end

private

  def default_classes
    %w(govuk-accordion)
  end

  def heading_tag(level)
    fail(ArgumentError, "heading_level must be 1-6") unless level.in?(1..6)

    %(h#{level})
  end

  class Section < GovukComponent::Base
    attr_reader :title, :summary, :expanded

    alias_method :expanded?, :expanded

    def initialize(title:, summary: nil, expanded: false, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @title    = title
      @summary  = summary
      @expanded = expanded
    end

    def id(suffix: nil)
      [title.parameterize, suffix].compact.join('-')
    end

    def call
      tag.div(content, id: id(suffix: 'content'), class: %w(govuk-accordion__section-content), aria: { labelledby: id })
    end

  private

    def default_classes
      %w(govuk-accordion__section).tap do |classes|
        classes.append("govuk-accordion__section--expanded") if expanded?
      end
    end
  end
end
