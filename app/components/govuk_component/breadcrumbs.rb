class GovukComponent::Breadcrumbs < GovukComponent::Base
  attr_accessor :breadcrumbs

  def initialize(breadcrumbs:, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @breadcrumbs = breadcrumbs
  end

private

  def default_classes
    %w(govuk-breadcrumbs)
  end
end
