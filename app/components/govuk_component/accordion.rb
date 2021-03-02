class GovukComponent::Accordion < GovukComponent::Base
  include ViewComponent::Slotable

  with_slot :section, collection: true, class_name: 'Section'
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

  class Section < GovukComponent::Slot
    attr_accessor :title, :summary, :expanded

    alias_method :expanded?, :expanded

    def initialize(title:, summary: nil, expanded: false, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      self.title   = title
      self.summary = summary
      self.expanded = expanded
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
