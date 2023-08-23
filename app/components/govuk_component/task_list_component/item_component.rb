module GovukComponent
  class TaskListComponent::ItemComponent < GovukComponent::Base
    renders_one :title, "GovukComponent::TaskListComponent::TitleComponent"
    renders_one :status, "GovukComponent::TaskListComponent::StatusComponent"

    attr_reader :title_text, :status, :href, :hint

    def initialize(title: nil, href: nil, hint: nil, status: nil, classes: [], html_attributes: {})
      @title_text  = title
      @href        = href
      @hint        = hint
      @status      = status

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.li(safe_join([title_content, hint_content, status_content]), **html_attributes)
    end

  private

    def title_content
      title || with_title(text: title_text, href: href, hint: hint)
    end

    def status_content
      case status
      when String
        with_status(text: status)
      when Hash
        with_status(**status)
      else status
      end
    end

    def hint_content
      tag.div(hint, class: %w(govuk-task-list__task_hint))
    end

    def default_attributes
      { class: 'govuk-task-list__item' }
    end
  end
end
