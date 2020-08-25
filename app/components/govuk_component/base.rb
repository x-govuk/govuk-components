class GovukComponent::Base < ViewComponent::Base
  attr_reader :html_attributes

  def initialize(classes: [], html_attributes: {})
    @classes         = parse_classes(classes)
    @html_attributes = html_attributes
  end

  def classes
    default_classes.concat(@classes).join(' ')
  end

private

  def parse_classes(classes)
    return [] unless classes.present?

    case classes
    when Array
      classes
    when String
      classes.split
    end
  end
end
