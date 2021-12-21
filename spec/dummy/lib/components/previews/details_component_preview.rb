class DetailsComponentPreview < ViewComponent::Preview
  # @label Basic details component
  #
  # Make a page easier to scan by letting users reveal more detailed
  # information only if they need it.
  def details
    render GovukComponent::DetailsComponent.new(
      summary_text: 'Help with nationality',
      text: <<~NATIONALITY_TEXT
        We need to know your nationality so we can work out which elections
        you’re entitled to vote in.

        If you cannot provide your nationality, you’ll have to send copies of
        identity documents through the post.
      NATIONALITY_TEXT
    )
  end

  # @label Details component with HTML summary and text
  #
  # Make a page easier to scan by letting users reveal more detailed
  # information only if they need it.
  def details_with_html_summary_and_text
    render GovukComponent::DetailsComponent.new do |details|
      details.summary_html { "Help with nationality" }
      
      safe_join([
        tag.p("We need to know your nationality so we can work out which elections you’re entitled to vote in."),
        tag.p("If you cannot provide your nationality, you’ll have to send copies of identity documents through the post.")
      ])
    end
  end

  # @label Details component that starts open
  #
  # The open keyword argument can make the details element render in an open state
  def details_that_start_open
    render GovukComponent::DetailsComponent.new(
      open: true,
      summary_text: 'Help with nationality',
      text: <<~NATIONALITY_TEXT
        We need to know your nationality so we can work out which elections
        you’re entitled to vote in.

        If you cannot provide your nationality, you’ll have to send copies of
        identity documents through the post.
      NATIONALITY_TEXT
    )
  end

  # @label Details component with custom id, classes and HTML attributes
  #
  # The open keyword argument can make the details element render in an open state
  def details_with_custom_id_classes_and_html_attributes
    render GovukComponent::DetailsComponent.new(
      id: "some-details",
      classes: %w(smooth-reveal),
      html_attributes: { data: { event: 'details-reveal' } },
      summary_text: 'Help with nationality',
      text: <<~NATIONALITY_TEXT
        We need to know your nationality so we can work out which elections
        you’re entitled to vote in.

        If you cannot provide your nationality, you’ll have to send copies of
        identity documents through the post.
      NATIONALITY_TEXT
    )
  end
end
