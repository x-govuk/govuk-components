class GovukComponent::PhaseBannerComponent < GovukComponent::Base
  attr_reader :text, :phase_tag

  def initialize(
    tag: { text: config.default_phase_banner_tag },
    text: config.default_phase_banner_text,
    classes: [],
    html_attributes: {}
  )
    @phase_tag = tag
    @text      = text

    super(classes: classes, html_attributes: html_attributes)
  end

  def phase_tag_component
    GovukComponent::TagComponent.new(**phase_tag, classes: "#{brand}-phase-banner__content__tag")
  end

private

  def default_attributes
    { class: "#{brand}-phase-banner" }
  end
end
