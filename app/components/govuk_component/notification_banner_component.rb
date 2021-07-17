class GovukComponent::NotificationBannerComponent < GovukComponent::Base
  attr_reader :title, :title_id, :text, :success, :title_heading_level, :disable_auto_focus

  renders_many :headings, "Heading"

  def initialize(title:, text: nil, success: false, title_heading_level: 2, title_id: "govuk-notification-banner-title", disable_auto_focus: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title               = title
    @title_id            = title_id
    @text                = text
    @success             = success
    @title_heading_level = title_heading_level
    @disable_auto_focus  = disable_auto_focus
  end

  def render?
    headings.any? || text.present? || content.present?
  end

  def classes
    super.append(success_class).compact
  end

  def success_class
    %(govuk-notification-banner--success) if success
  end

  def title_tag
    fail "title_heading_level must be a number between 1 and 6" unless title_heading_level.is_a?(Integer) && title_heading_level.in?(1..6)

    "h#{title_heading_level}"
  end

  class Heading < GovukComponent::Base
    attr_reader :text, :link_href, :link_text

    def initialize(text: nil, link_text: nil, link_href: nil, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @text      = text
      @link_text = link_text
      @link_href = link_href
    end

    def call
      tag.div(class: classes, **html_attributes) do
        if text.present?
          safe_join([text, link].compact, " ")
        else
          content
        end
      end
    end

    def link
      link_to(link_text, link_href, class: 'govuk-notification-banner__link') if link_text.present? && link_href.present?
    end

    def default_classes
      %w(govuk-notification-banner__heading)
    end
  end

private

  def default_classes
    %w(govuk-notification-banner)
  end

  def data_params
    { "module" => "govuk-notification-banner", "disable-auto-focus" => disable_auto_focus }.compact
  end
end
