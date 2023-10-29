module GovukComponent
  class TaskListComponent::ItemComponent < GovukComponent::Base
    renders_one :status, ->(text: nil, classes: [], html_attributes: {}, &block) do
      GovukComponent::TaskListComponent::StatusComponent.new(
        identifier: @identifier,
        text: text,
        classes: classes,
        html_attributes: html_attributes,
        &block
      )
    end

    renders_one :title, ->(text: nil, href: nil, hint: nil, classes: [], html_attributes: {}, &block) do
      GovukComponent::TaskListComponent::TitleComponent.new(
        identifier: @identifier,
        text: text,
        href: href,
        hint: hint,
        classes: classes,
        html_attributes: html_attributes,
        &block
      )
    end

    attr_reader :raw_title, :hint, :href, :raw_status

    def initialize(title: nil, href: nil, hint: nil, identifier: SecureRandom.hex(3), status: {}, classes: [], html_attributes: {})
      @raw_title  = title
      @href       = href
      @hint       = hint
      @raw_status = status
      @identifier = identifier

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      adjusted_html_attributes = if href.present? || title&.href.present?
                                   html_attributes_with_link_class
                                 else
                                   html_attributes
                                 end

      tag.li(safe_join([title_content, status_content].compact), **adjusted_html_attributes)
    end

  private

    def title_content
      title || with_title(**title_attributes)
    end

    def status_content
      status || with_status(**status_attributes)
    end

    def default_attributes
      { class: 'govuk-task-list__item' }
    end

    def title_attributes
      { text: raw_title, href: href, hint: hint }
    end

    def html_attributes_with_link_class
      html_attributes.tap { |h| h[:class].append("govuk-task-list__item--with-link") }
    end

    def status_attributes
      raw_status.is_a?(String) ? { text: raw_status } : raw_status
    end
  end
end
