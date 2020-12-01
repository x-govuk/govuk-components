class GovukComponent::NotificationBanner < GovukComponent::Base
  attr_accessor :title, :heading, :link, :success

  def initialize(title:, heading:, link_text: nil, link_target: nil, success: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title   = title
    @heading = heading
    @success = success

    if link_text && link_target
      @link = link_to(link_text, link_target, class: "govuk-notification-banner__link")
    end
  end

  def success_class
    %(govuk-notification-banner--success) if success?
  end

  def success?
    @success
  end

private

  def default_classes
    %w(govuk-notification-banner)
  end
end
