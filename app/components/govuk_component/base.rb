class GovukComponent::Base < ViewComponent::Base
  include GovukComponent::Traits::CustomClasses
  include GovukComponent::Traits::CustomHtmlAttributes

  def initialize(classes: [], html_attributes: {})
    @classes         = parse_classes(classes)
    @html_attributes = html_attributes
  end

  # Redirect #add_name to #name to make building components
  # with slots feel more DSL-like
  def self.wrap_slot(name)
    define_method(%(add_#{name})) do |*args, **kwargs, &block|
      send(name, *args, **kwargs, &block)
    end
  end
end
