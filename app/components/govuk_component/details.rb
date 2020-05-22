class GovukComponent::Details < ViewComponent::Base
  attr_accessor :summary, :text

  def initialize(summary:, text: nil)
    @summary = summary
    @text    = text
  end
end
