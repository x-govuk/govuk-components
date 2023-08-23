module GovukComponent
  class TaskListComponent::StatusComponent < GovukComponent::Base
    attr_reader :text, :href, :colour

    def initialize(text: nil, href: nil, colour: nil, classes: [], html_attributes: {})
      @text = text
      @href = href
      @colour = colour

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.div(**html_attributes) do
        render(GovukComponent::TagComponent.new(text: text, colour: colour))
      end
    end

  private

    def default_attributes
      { class: %w(govuk-task-list__status) }
    end
  end
end
