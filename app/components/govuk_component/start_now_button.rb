class GovukComponent::StartNowButton < ViewComponent::Base
  attr_accessor :text, :href

  def initialize(text:, href:)
    @text = text
    @href = href
  end
end
