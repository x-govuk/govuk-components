class GovukComponent::Breadcrumbs < ViewComponent::Base
  attr_accessor :breadcrumbs

  def initialize(breadcrumbs:)
    @breadcrumbs = breadcrumbs
  end
end
