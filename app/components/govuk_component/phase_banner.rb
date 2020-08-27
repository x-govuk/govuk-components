class GovukComponent::PhaseBanner < GovukComponent::Base
  attr_accessor :phase, :text

  def initialize(phase:, text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @phase = phase
    @text  = text
  end

private

  def default_classes
    %w(govuk-phase-banner)
  end
end
