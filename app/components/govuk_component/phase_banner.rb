class GovukComponent::PhaseBanner < ViewComponent::Base
  attr_accessor :tag, :text
  with_content_areas :html

  def initialize(tag:, text: nil)
    @tag  = tag
    @text = text
  end
end
