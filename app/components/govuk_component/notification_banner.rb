class GovukComponent::NotificationBanner < GovukComponent::Base
  attr_accessor :title, :success

  include ViewComponent::Slotable
  with_slot :heading, collection: true, class_name: 'Heading'

  def initialize(title:, success: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title   = title
    @success = success
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
