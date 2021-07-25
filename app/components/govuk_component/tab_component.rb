class GovukComponent::TabComponent < GovukComponent::Base
  renders_many :tabs, "Tab"

  attr_reader :title, :id

  def initialize(title:, id: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title = title
    @id    = id
  end

private

  def default_classes
    %w(govuk-tabs)
  end

  class Tab < GovukComponent::Base
    attr_reader :label, :text

    def initialize(label:, text: nil, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @label = label
      @text  = text
    end

    def id(prefix: nil)
      [prefix, label.parameterize].join
    end

    def hidden_class(i = nil)
      %(govuk-tabs__panel--hidden) unless i&.zero?
    end

    def li_classes(i = nil)
      %w(govuk-tabs__list-item).tap do |c|
        c.append("govuk-tabs__list-item--selected") if i&.zero?
      end
    end

    def li_link
      link_to(label, id(prefix: '#'), class: "govuk-tabs__tab")
    end

    def default_classes
      %w(govuk-tabs__panel)
    end

    def call
      content || text || fail(ArgumentError, "no text or content")
    end
  end
end
