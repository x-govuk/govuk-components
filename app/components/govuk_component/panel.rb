class GovukComponent::Panel < GovukComponent::Base
  attr_accessor :title, :body

  def initialize(title: nil, body: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title = title
    @body  = body
  end

private

  def default_classes
    %w(govuk-panel govuk-panel--confirmation)
  end

  def display_title?
    @title.present?
  end

  def display_body?
    (@body || content).present?
  end

  def render?
    display_title? || display_body?
  end
end
