module GovukComponent
  class TaskListComponent::StatusComponent < GovukComponent::Base
    attr_reader :id_prefix, :text, :cannot_start_yet, :count

    def initialize(text: nil, id_prefix: nil, count: nil, cannot_start_yet: false, classes: [], html_attributes: {})
      @text             = text
      @count            = count
      @id_prefix        = id_prefix
      @cannot_start_yet = cannot_start_yet

      super(classes:, html_attributes:)
    end

    def call
      tag.div(status_text, **html_attributes)
    end

    def render?
      status_text.present?
    end

  private

    def default_attributes
      {
        class: class_names(
          "govuk-task-list__status",
          "govuk-task-list__status--cannot-start-yet" => cannot_start_yet,
        ),
        id: [id_prefix, count, "status"].compact.join("-"),
      }
    end

    def status_text
      text || content
    end
  end
end
