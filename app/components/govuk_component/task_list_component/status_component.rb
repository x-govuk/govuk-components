module GovukComponent
  class TaskListComponent::StatusComponent < GovukComponent::Base
    attr_reader :text

    def initialize(text: nil, classes: [], html_attributes: {})
      @text = text

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.div(text, **html_attributes)
    end

  private

    def default_attributes
      { class: %w(govuk-task-list__status) }
    end
  end
end
