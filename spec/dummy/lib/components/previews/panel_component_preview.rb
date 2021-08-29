class PanelComponentPreview < ViewComponent::Preview
  # @label Panel
  #
  # The panel component is a visible container used on confirmation or results
  # pages to highlight important content.
  def panel
    render GovukComponent::PanelComponent.new(
      title_text: 'Springfield',
      text: 'A noble spirit embiggens the smallest man'
    )
  end

  # @label Panel with custom heading level
  #
  # Heading levels can be adjusted using the `heading_level` parameter. This example generates a `h3` element.
  #
  # @label Panel with custom heading level
  def panel_with_custom_heading_level
    render GovukComponent::PanelComponent.new(
      title_text: 'Springfield',
      text: 'A noble spirit embiggens the smallest man',
      heading_level: 3,
    )
  end

  # @label Panel with custom HTML content
  #
  # Any HTML content within the block will be form the panel's text. If both a block and text
  # are provided the block will take precedence.
  #
  def panel_with_custom_html
    render GovukComponent::PanelComponent.new(title_text: 'Springfield', heading_level: 3) do
      'A noble spirit embiggens the <strong>smallest</strong> man'.html_safe
    end
  end

  # @label Panel with custom title HTML
  #
  # The `title_html` slot can be used to set a title with custom HTML. If both a title argument and
  # block are provided the block will take precedence.
  def panel_with_custom_title_html
    render GovukComponent::PanelComponent.new(text: 'A noble spirit embiggens the smallest man') do |panel|
      panel.title_html { '<em>Springfield</em>'.html_safe }
    end
  end

  # @label Panel with custom classes and HTML attributes
  #
  # Any `classes` and `html_attributes` provided will be added to the panel container.
  #
  # As the panel is rendered using Rails' `#tag` helper, we can use the `data` and `aria` shorthand.
  def panel_with_custom_classes_and_html_attributes
    render GovukComponent::PanelComponent.new(
      title_text: 'Springfield',
      text: 'A noble spirit embiggens the smallest man',
      classes: 'super-important',
      html_attributes: {
        data: { controller: 'notifier' },
        aria: { role: 'alert' },
        lang: 'en-GB'
      }
    )
  end
end
