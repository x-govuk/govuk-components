class GovukComponent::Breadcrumbs < GovukComponent::Base
  attr_accessor :breadcrumbs

  def initialize(breadcrumbs:, classes: [])
    super(classes: classes)

    @breadcrumbs = breadcrumbs
  end

private

  def default_classes
    %w(govuk-breadcrumbs)
  end
end
