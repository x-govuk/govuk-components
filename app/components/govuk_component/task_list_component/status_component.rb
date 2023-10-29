module GovukComponent
  class TaskListComponent::StatusComponent < GovukComponent::Base
    attr_reader :text

    def initialize(text: nil, classes: [], html_attributes: {})
      @text = text

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.div(status_text, **html_attributes)
    end

    def render?
      status_text.present?
    end

  private

    def default_attributes
      { class: %w(govuk-task-list__status) }
    end

    def status_text
      text || content
    end
  end
end
