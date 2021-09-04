class BackLinkComponentPreview < ViewComponent::Preview
  # @label Basic back link
  #
  # The the back link component to help users go back to the previous page in a
  # multi-page transaction.
  def back_link
    render GovukComponent::BackLinkComponent.new(href: '#back-one-page')
  end

  # @label Back link with custom text
  #
  # If the text should be something other than 'Back' it can be overridden.
  def back_link_with_custom_text
    render GovukComponent::BackLinkComponent.new(href: '#back-one-page', text: 'Retreat')
  end

  # @label Back link with text provided in a block
  #
  # When markup
  def back_link_with_custom_text_in_a_block
    render GovukComponent::BackLinkComponent.new(href: '#back-one-page') do
      tag.span("Retreat")
    end
  end

  # @label Back link with custom classes and HTML attributes
  #
  # 
  def back_link_with_custom_classes_and_html_attributes
    render GovukComponent::BackLinkComponent.new(href: '#back-one-page', classes: %(massive), html_attributes: { data: { label: 'go-back' } })
  end
end
