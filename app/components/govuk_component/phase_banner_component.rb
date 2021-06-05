class GovukComponent::PhaseBannerComponent < GovukComponent::Base
  attr_accessor :text

  def initialize(phase_tag: nil, text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @phase_tag = phase_tag
    @text      = text
  end

  def phase_tag_component
    GovukComponent::TagComponent.new(classes: "govuk-phase-banner__content__tag", **@phase_tag)
  end

private

  def default_classes
    %w(govuk-phase-banner)
  end
end
