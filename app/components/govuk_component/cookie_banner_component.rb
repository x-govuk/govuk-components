class GovukComponent::CookieBannerComponent < GovukComponent::Base
  renders_many :messages, GovukComponent::CookieBannerComponent::MessageComponent

  attr_accessor :aria_label, :hidden

  def initialize(aria_label: "Cookie banner", hidden: false, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @aria_label = aria_label
    @hidden     = hidden
  end

  def call
    tag.div(class: classes, role: "region", aria: { label: aria_label }, hidden: hidden, **html_attributes) do
      safe_join(messages)
    end
  end

private

  def default_classes
    %w(govuk-cookie-banner)
  end
end
