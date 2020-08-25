class GovukComponent::Accordion < GovukComponent::Base
  include ViewComponent::Slotable

  with_slot :section, collection: true, class_name: 'Section'

  attr_accessor :id

  def initialize(id: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id
  end

private

  def default_classes
    %w(govuk-accordion)
  end

  class Section < ViewComponent::Slot
    attr_accessor :title, :summary

    def initialize(title:, summary: nil)
      self.title   = title
      self.summary = summary
    end

    def id(suffix: nil)
      [title.parameterize, suffix].compact.join('-')
    end
  end
end
