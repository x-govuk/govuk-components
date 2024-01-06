class GovukComponent::NotificationBannerComponent < GovukComponent::Base
  attr_reader :title_text, :title_id, :text, :success, :title_heading_level, :disable_auto_focus, :role

  renders_one :title_html
  renders_many :headings, "Heading"

  def initialize(
    title_text: nil,
    text: nil,
    role: nil,
    success: config.default_notification_title_success,
    title_heading_level: config.default_notification_title_heading_level,
    title_id: config.default_notification_banner_title_id,
    disable_auto_focus: config.default_notification_disable_auto_focus,
    classes: [],
    html_attributes: {}
  )
    @title_text          = title_text
    @title_id            = title_id
    @text                = text
    @success             = success
    @role                = role || default_role
    @title_heading_level = title_heading_level
    @disable_auto_focus  = disable_auto_focus

    super(classes:, html_attributes:)
  end

  def render?
    headings.any? || text.present? || content?
  end

  class Heading < GovukComponent::Base
    attr_reader :text, :link_href, :link_text

    def initialize(text: nil, link_text: nil, link_href: nil, classes: [], html_attributes: {})
      @text      = text
      @link_text = link_text
      @link_href = link_href

      super(classes:, html_attributes:)
    end

    def call
      tag.div(**html_attributes) do
        if text.present?
          safe_join([text, link].compact, " ")
        else
          content
        end
      end
    end

    def link
      link_to(link_text, link_href, class: "#{brand}-notification-banner__link") if link_text.present? && link_href.present?
    end

    def default_attributes
      { class: ["#{brand}-notification-banner__heading"] }
    end
  end

private

  def default_attributes
    {
      class: class_names(
        "#{brand}-notification-banner",
        "#{brand}-notification-banner--success" => success
      ),
      data: {
        "module" => "#{brand}-notification-banner",
        "disable-auto-focus" => disable_auto_focus
      },
      role:,
      aria: { labelledby: title_id },
    }
  end

  def title_content
    title_html || title_text
  end

  def title_tag
    fail "title_heading_level must be a number between 1 and 6" unless title_heading_level.is_a?(Integer) && title_heading_level.in?(1..6)

    "h#{title_heading_level}"
  end

  def default_role
    success ? "alert" : "region"
  end
end
