class GovukComponent::BackLink < GovukComponent::Base
  attr_accessor :text, :href, :options

  def initialize(text:, href:, classes: nil, attributes: {})
    super(classes: classes)

    @text       = text
    @href       = href
    @attributes = attributes
  end

private

  def default_classes
    %w(govuk-back-link)
  end

  def options
    { class: classes }.merge(@attributes)
  end
end
