class GovukComponent::CookieBanner < GovukComponent::Base
  renders_one :body
  renders_one :actions

  attr_accessor :title, :aria_label

  def initialize(title: nil, aria_label: "Cookie banner", classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title      = title
    @aria_label = aria_label
  end

private

  def default_classes
    %w(govuk-cookie-banner)
  end
end
