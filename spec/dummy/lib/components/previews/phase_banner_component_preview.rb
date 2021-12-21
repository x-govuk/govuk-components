class PhaseBannerComponentPreview < ViewComponent::Preview
  # @label Phase banner
  #
  # Use the phase banner component to show users your service is still being worked on.
  def phase_banner
    render GovukComponent::PhaseBannerComponent.new(tag: { text: 'beta' }, text: 'This is a new service')
  end

  # @label Phase banner with a custom tag
  #
  # The tag parameter takes the same arguments as the GovukComponent::TagComponent, any colour, text, classes
  # or additional HTML attributes can be passed to it.
  def phase_banner_with_custom_tag
    render GovukComponent::PhaseBannerComponent.new(
      tag: {
        text: 'beta',
        colour: 'pink',
        classes: 'super-important',
        html_attributes: { data: { component: 'beta-tag' } }
      },
      text: 'This is a new service with custom attributes'
    )
  end

  # @label Phase banner with custom classes and HTML attributes
  #
  #
  def phase_banner_with_custom_class_and_html_attributes
    render GovukComponent::PhaseBannerComponent.new(
      tag: { text: 'beta' },
      text: 'This is a new service with custom attributes',
      classes: 'very-important',
      html_attributes: { data: { component: 'phase-banner' } }
    )
  end
end
