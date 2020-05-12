class GovukComponent::PhaseBanner < ViewComponent::Base
  attr_accessor :tag, :text

  def initialize(tag:, text: nil)
    @tag  = tag
    @text = text
  end
end
