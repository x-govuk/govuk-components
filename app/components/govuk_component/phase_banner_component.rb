class GovukComponent::PhaseBannerComponent < GovukComponent::Base
  attr_reader :text, :phase_tag

  def initialize(tag: nil, text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @phase_tag = tag
    @text      = text
  end

  def phase_tag_component
    GovukComponent::TagComponent.new(**phase_tag.deep_merge(classes: "govuk-phase-banner__content__tag"))
  end

private

  def default_classes
    %w(govuk-phase-banner)
  end
end
