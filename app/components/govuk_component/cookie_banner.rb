class GovukComponent::CookieBanner < GovukComponent::Base
  with_content_areas :body, :actions

  attr_accessor :title

  def initialize(title: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title = title
  end

private

  def default_classes
    %w(govuk-cookie-banner)
  end
end
