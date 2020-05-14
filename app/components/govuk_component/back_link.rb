class GovukComponent::BackLink < ViewComponent::Base
  attr_accessor :text, :href, :options

  def initialize(text:, href:, classes: nil, attributes: nil)
    @text = text
    @href = href
    @classes = "govuk-back-link"
    @classes << " #{classes}" if classes.present?

    @options = { class: @classes }
    @options.merge!(attributes) if attributes.present?
  end
end
