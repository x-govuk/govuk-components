class GovukComponent::PhaseBannerComponent < GovukComponent::Base
  attr_reader :text, :phase_tag

  def initialize(
    tag: { text: Govuk::Components.config.default_phase_banner_component_tag },
    text: Govuk::Components.config.default_phase_banner_component_text,
    classes: [],
    html_attributes: {}
  )
    @phase_tag = tag
    @text      = text

    super(classes: classes, html_attributes: html_attributes)
  end

  def phase_tag_component
    GovukComponent::TagComponent.new(**phase_tag.deep_merge(classes: "govuk-phase-banner__content__tag"))
  end

private

  def default_attributes
    { class: %w(govuk-phase-banner) }
  end
end
