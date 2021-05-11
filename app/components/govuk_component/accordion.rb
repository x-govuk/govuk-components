class GovukComponent::Accordion < GovukComponent::Base
  renders_many :sections, "Section"
  wrap_slot :section

  attr_accessor :id

  def initialize(id: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id
  end

private

  def default_classes
    %w(govuk-accordion)
  end

  class Section < GovukComponent::Base
    attr_accessor :title, :summary, :expanded

    alias_method :expanded?, :expanded

    def initialize(title:, summary: nil, expanded: false, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      self.title   = title
      self.summary = summary
      self.expanded = expanded
    end

    def call
      tag.div(content, id: id(suffix: 'content'), class: %w(govuk-accordion__section-content), aria: { labelledby: id })
    end

    def id(suffix: nil)
      [title.parameterize, suffix].compact.join('-')
    end

    def classes
      super + (expanded? ? %w(govuk-accordion__section--expanded) : [])
    end

  private

    def default_classes
      %w(govuk-accordion__section)
    end
  end
end
