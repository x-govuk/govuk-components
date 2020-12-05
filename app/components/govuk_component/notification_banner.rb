class GovukComponent::NotificationBanner < GovukComponent::Base
  attr_reader :title, :success, :title_heading_level

  include ViewComponent::Slotable
  with_slot :heading, collection: true, class_name: 'Heading'

  def initialize(title:, success: false, title_heading_level: 2, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title               = title
    @success             = success
    @title_heading_level = title_heading_level
  end

  def success_class
    %(govuk-notification-banner--success) if success?
  end

  def success?
    @success
  end

  def render?
    headings.any?
  end

  def title_tag
    fail "title_heading_level must be a number between 1 and 6" unless title_heading_level.is_a?(Integer) && title_heading_level.in?(1..6)

    "h#{title_heading_level}"
  end

  class Heading < ViewComponent::Slot
    attr_accessor :text, :link_target, :link_text

    def initialize(text:, link_text: nil, link_target: nil)
      @text = text
      @link_text = link_text
      @link_target = link_target
    end

    def default_classes
      %w(govuk-notification-banner__heading)
    end
  end

private

  def default_classes
    %w(govuk-notification-banner)
  end
end
