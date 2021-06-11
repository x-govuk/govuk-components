class GovukComponent::AccordionComponent < GovukComponent::Base
  renders_many :sections, "Section"

  attr_reader :id

  def initialize(id: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id
  end

private

  def default_classes
    %w(govuk-accordion)
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
