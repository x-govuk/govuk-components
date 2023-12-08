module GovukComponent
  class TaskListComponent::StatusComponent < GovukComponent::Base
    attr_reader :id_prefix, :text, :count

    def initialize(text: nil, id_prefix: nil, count: nil, classes: [], html_attributes: {})
      @text      = text
      @count     = count
      @id_prefix = id_prefix

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
      { class: %w(govuk-task-list__status), id: [id_prefix, count, "status"].compact.join("-") }
    end

    def status_text
      text || content
    end
  end
end
