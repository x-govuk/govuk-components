class GovukComponent::Details < GovukComponent::Base
  attr_accessor :summary, :description

  def initialize(summary:, description: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @summary     = summary
    @description = description
  end

private

  def default_classes
    %w(govuk-details)
  end
end
