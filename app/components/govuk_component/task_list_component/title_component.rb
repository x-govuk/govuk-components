module GovukComponent
  class TaskListComponent::TitleComponent < GovukComponent::Base
    using HTMLAttributesUtils

    attr_reader :identifier, :text, :href, :hint

    def initialize(identifier: nil, text: nil, href: nil, hint: nil, classes: [], html_attributes: {})
      @text       = text
      @href       = href
      @hint       = hint
      @identifier = identifier

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.div(**html_attributes) { safe_join([title_content, hint_content]) }
    end

  private

    def title_content
      (href.present?) ? govuk_link_to(text, href, **link_attributes) : text
    end

    def hint_content
      return if hint.blank?

      tag.div(hint, class: "govuk-task-list__hint", id: hint_id)
    end

    def default_attributes
      { class: "govuk-task-list__name-and-hint" }
    end

    def link_attributes
      { class: "govuk-task-list__link", **aria_described_by_attributes }
    end

    def aria_described_by_attributes
      status_id = "#{identifier}-status"

      { aria: { describedby: [*status_id, *hint_id] } }
    end

    def hint_id
      "#{identifier}-hint" if hint.present?
    end
  end
end
