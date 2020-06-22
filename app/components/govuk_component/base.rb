class GovukComponent::Base < ViewComponent::Base
  def initialize(classes: [])
    @classes = parse_classes(classes)
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
