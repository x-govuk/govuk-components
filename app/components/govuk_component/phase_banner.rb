class GovukComponent::PhaseBanner < GovukComponent::Base
  attr_accessor :phase, :text

  def initialize(phase:, text: nil, classes: [])
    super(classes: classes)

    @phase = phase
    @text  = text
  end

private

  def default_classes
    %w(govuk-phase-banner)
  end
end
