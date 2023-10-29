module GovukComponent
  class TaskListComponent::StatusComponent < GovukComponent::Base
    attr_reader :identifier, :text

    def initialize(identifier: nil, text: nil, classes: [], html_attributes: {})
      @text       = text
      @identifier = identifier

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
      { class: %w(govuk-task-list__status), id: "#{identifier}-status" }
    end

    def status_text
      text || content
    end
  end
end
