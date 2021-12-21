class TabComponentPreview < ViewComponent::Preview
  # @label Tabs component
  #
  # The tabs component lets users navigate between related sections of content, displaying one section at a time.
  def tabs
    render GovukComponent::TabComponent.new(title: 'Days of the week') do |component|
      component.tab(label: 'Monday') do
        tag.p("Monday's child is fair of face", class: 'govuk-body')
      end

      component.tab(label: 'Tuesday') do
        tag.p("Tuesday's child is full of grace", class: 'govuk-body')
      end

      component.tab(label: 'Wednesday') do
        tag.p("Wednesday's child is full of woe", class: 'govuk-body')
      end
    end
  end
end
