class GovukComponent::Tabs < GovukComponent::Base
  include ViewComponent::Slotable

  attr_accessor :title

  with_slot :tab, collection: true, class_name: 'Tab'

  def initialize(title:, classes: [])
    super(classes: classes)

    self.title = title
  end

private

  def default_classes
    %w(govuk-tabs)
  end

  class Tab < ViewComponent::Slot
    attr_accessor :title

    def initialize(title:)
      self.title = title
    end

    def id(prefix: nil)
      [prefix, title.parameterize].join
    end
  end
end
