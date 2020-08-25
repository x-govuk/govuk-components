class GovukComponent::Panel < GovukComponent::Base
  attr_accessor :title, :body

  def initialize(title:, body:, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title = title
    @body  = body
  end

private

  def default_classes
    %w(govuk-panel govuk-panel--confirmation)
  end
end
