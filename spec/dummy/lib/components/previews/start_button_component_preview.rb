class StartButtonComponentPreview < ViewComponent::Preview
  # @label Start button
  #
  # Use a start button for the main call to action on your service’s start page. Start buttons do not submit form data, so they use a link tag rather than a button tag.
  def start_button
    render GovukComponent::StartButtonComponent.new(text: 'Start now', href: '#')
  end

  # @label Start button with custom classes and HTML attributes
  #
  # Additional classes and HTML attributes can be passed in if needed.
  def start_button_with_custom_classes_and_html_attributes
    render GovukComponent::StartButtonComponent.new(
      text: 'Start now',
      href: '#',
      classes: 'flashing',
      html_attributes: { data: { 'start-animation' => 'immediately' } }
    )
  end
end
