class TagComponentPreview < ViewComponent::Preview
  # @label Tag component
  #
  # Use the tag component to show users the status of something.
  def tag
    render(GovukComponent::TagComponent.new(text: 'important'))
  end

  # @label Coloured tag
  #
  # Tags can be rendered in the colour provided in the 'colour' argument. Available colours
  # are grey green turquoise blue red purple pink orange and yellow
  def coloured_tag
    render(GovukComponent::TagComponent.new(text: 'new', colour: 'green'))
  end

  # @label Tag with custom classes and HTML attributes
  def tag_with_custom_classes_and_html_attributes
    render(GovukComponent::TagComponent.new(text: 'warning', colour: 'orange', classes: 'large-tag', html_attributes: { data: { animate: 'yes' } }))
  end
end
