class AccordionComponentPreview < ViewComponent::Preview
  include ActionView::Context

  # @label Basic accordion
  #
  # The accordion component lets users show and hide sections of related
  # content on a page. Summary text can be passed in either via a block
  # or using the summary_text parameter.
  def accordion
    render GovukComponent::AccordionComponent.new do |accordion|
      accordion.section(heading_text: 'Home electronics') do
        tag.p("Electronic equipment intended for everyday use", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Appliances', summary_text: "Machines which assists in household functions such as cooking, cleaning and food preservation.")
      accordion.section(heading_text: 'Toys', summary_text: "Tools that provide entertainment while fulfilling an educational role.")
    end
  end

  # @label Accordion with section summaries
  #
  # Summary text can be provided to give additional context
  def accordion_with_summaries
    render GovukComponent::AccordionComponent.new do |accordion|
      accordion.section(heading_text: 'Home electronics', summary_text: 'Entertainment, communication and recreation') do
        tag.p("Electronic equipment intended for everyday use", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Appliances', summary_text: 'Laundry, cookers and vacuum cleaners') do
        tag.p("Machines which assists in household functions such as cooking, cleaning and food preservation.", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Toys', summary_text: 'Games, dolls, action figures and blocks') do
        tag.p("Tools that provide entertainment while fulfilling an educational role.", class: 'govuk-body')
      end
    end
  end

  # @label Accordion with a custom id and custom classes on each section
  #
  # The accordion can be given custom classes and a custom id, each of its sections can also be provided
  # with additional classes.
  def accordion_with_custom_id
    render GovukComponent::AccordionComponent.new(id: 'abc', classes: %w(d e f g h i)) do |accordion|
      accordion.section(heading_text: 'Home electronics', classes: %w(j k l)) do
        tag.p("Electronic equipment intended for everyday use", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Appliances', classes: %w(m n o)) do
        tag.p("Machines which assists in household functions such as cooking, cleaning and food preservation.", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Toys', classes: %w(p q r)) do
        tag.p("Tools that provide entertainment while fulfilling an educational role.", class: 'govuk-body')
      end
    end
  end

  # @label Accordion with pre-expanded sections
  #
  # Pass in 'expanded: true' to make the accordion always render it open.
  def accordion_with_pre_expanded_sections
    render GovukComponent::AccordionComponent.new do |accordion|
      accordion.section(heading_text: 'Home electronics', expanded: true) do
        tag.p("Electronic equipment intended for everyday use", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Appliances', expanded: true) do
        tag.p("Machines which assists in household functions such as cooking, cleaning and food preservation.", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Toys', expanded: true) do
        tag.p("Tools that provide entertainment while fulfilling an educational role.", class: 'govuk-body')
      end
    end
  end

  # @label Accordion with a custom heading level
  #
  # Accordions headings default to h2 but that can be easily overriden
  def accordion_with_custom_heading_level
    render GovukComponent::AccordionComponent.new(heading_level: 4) do |accordion|
      accordion.section(heading_text: 'Home electronics') do
        tag.p("Electronic equipment intended for everyday use", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Appliances') do
        tag.p("Machines which assists in household functions such as cooking, cleaning and food preservation.", class: 'govuk-body')
      end

      accordion.section(heading_text: 'Toys') do
        tag.p("Tools that provide entertainment while fulfilling an educational role.", class: 'govuk-body')
      end
    end
  end
end
