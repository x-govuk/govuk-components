class GovukComponent::StartNowButton < GovukComponent::Base
  attr_accessor :text, :href

  def initialize(text:, href:, classes: [])
    super(classes: classes)

    @text = text
    @href = href
  end

private

  def default_classes
    %w(govuk-button govuk-button--start)
  end
end
