class GovukComponent::InsetText < ViewComponent::Base
  attr_accessor :text

  def initialize(text:)
    @text = text
  end

  def call
    tag.div(class: 'govuk-inset-text') { @text }
  end
end
