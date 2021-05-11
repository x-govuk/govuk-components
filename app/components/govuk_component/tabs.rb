class GovukComponent::Tabs < GovukComponent::Base
  attr_accessor :title

  renders_many :tabs, "Tab"
  wrap_slot :tab

  def initialize(title:, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    self.title = title
  end

private

  def default_classes
    %w(govuk-tabs)
  end

  class Tab < GovukComponent::Base
    attr_accessor :title

    def initialize(title:, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      self.title = title
    end

    def call
      content
    end

    def id(prefix: nil)
      [prefix, title.parameterize].join
    end

    def default_classes
      %w(govuk-tabs__panel)
    end

    def hidden_class(i = nil)
      %(govuk-tabs__panel--hidden) unless i&.zero?
    end
  end
end
