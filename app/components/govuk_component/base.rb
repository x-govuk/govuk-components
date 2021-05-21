class GovukComponent::Base < ViewComponent::Base
  include GovukComponent::Traits::CustomClasses
  include GovukComponent::Traits::CustomHtmlAttributes

  attr_reader :html_attributes

  def initialize(classes:, html_attributes:)
    @classes         = parse_classes(classes)
    @html_attributes = html_attributes

    super
  end

  def default_classes
    []
  end
end
