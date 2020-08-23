class GovukComponent::Details < GovukComponent::Base
  attr_accessor :summary, :description

  def initialize(summary:, description: nil, classes: [])
    super(classes: classes)

    @summary     = summary
    @description = description
  end

private

  def default_classes
    %w(govuk-details)
  end
end
