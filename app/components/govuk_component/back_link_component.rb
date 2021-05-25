class GovukComponent::BackLinkComponent < GovukComponent::Base
  attr_accessor :text, :href, :options

  def initialize(text:, href:, classes: nil, html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
    @href = href
  end

  def call
    link_to(@text, @href, class: classes, **html_attributes)
  end

private

  def default_classes
    %w(govuk-back-link)
  end
end
