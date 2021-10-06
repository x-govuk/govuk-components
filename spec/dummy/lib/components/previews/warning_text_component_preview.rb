class WarningTextComponentPreview < ViewComponent::Preview
  # @label Warning text
  def warning_text
    render(GovukComponent::WarningTextComponent.new(text: 'You can be fined up to £5,000 if you do not register.'))
  end

  # @label Warning text with block content
  def warning_text_with_block_content
    render(GovukComponent::WarningTextComponent.new) do
      'You can be fined up to £5,000 if you do not register.'
    end
  end

  # @label Warning text with custom classes and HTML attributes
  def warning_text_with_custom_classes_and_html_attributes
    render(
      GovukComponent::WarningTextComponent.new(
        text: 'You can be fined up to £5,000 if you do not register.',
        classes: 'extra-big',
        html_attributes: { data: { controller: 'loud-warning'} }
      )
    )
  end
end
