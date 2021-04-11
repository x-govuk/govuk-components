class GovukComponent::PhaseBanner < GovukComponent::Base
  attr_accessor :phase_tag, :text

  def initialize(phase_tag: nil, text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @phase_tag = GovukComponent::Tag.new(classes: "govuk-phase-banner__content__tag", **phase_tag)
    @text      = text
  end

private

  def default_classes
    %w(govuk-phase-banner)
  end
end
