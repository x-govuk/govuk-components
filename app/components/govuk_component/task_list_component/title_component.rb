module GovukComponent
  class TaskListComponent::TitleComponent < GovukComponent::Base
    using HTMLAttributesUtils

    attr_reader :id_prefix, :text, :href, :hint, :count

    def initialize(text: nil, href: nil, hint: nil, id_prefix: nil, count: nil, classes: [], html_attributes: {})
      @text       = text
      @href       = href
      @hint       = hint
      @id_prefix  = id_prefix
      @count      = count

      super(classes:, html_attributes:)
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
      { aria: { describedby: [*status_id, *hint_id] } }
    end

    def hint_id
      [id_prefix, count, "hint"].compact.join("-") if hint.present?
    end

    def status_id
      [id_prefix, count, "status"].compact.join("-")
    end
  end
end
