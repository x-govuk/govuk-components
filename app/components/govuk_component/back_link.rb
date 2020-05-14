class GovukComponent::BackLink < ViewComponent::Base
  attr_accessor :text, :href

  def initialize(text:, href:, classes: nil)
    @text = text
    @href = href
    @classes = classes
  end
end
