class GovukComponent::PhaseBannerComponent < GovukComponent::Base
  attr_reader :text, :phase_tag

  def initialize(
    tag: { text: config.default_phase_banner_tag },
    text: config.default_phase_banner_text,
    html_attributes: {}
  )
    @phase_tag = tag
    @text      = text

    super(html_attributes: html_attributes)
  end

  def phase_tag_component
    GovukComponent::TagComponent.new(**phase_tag.deep_merge(html_attributes: { class: "govuk-phase-banner__content__tag" }))
  end

private

  def default_attributes
    { class: %w(govuk-phase-banner) }
  end
end
