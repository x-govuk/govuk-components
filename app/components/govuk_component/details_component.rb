class GovukComponent::DetailsComponent < GovukComponent::Base
  attr_accessor :summary_text, :text

  renders_one :summary_html

  def initialize(summary_text:, text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @summary_text = summary_text
    @text         = text
  end

  def call
    tag.details(class: classes, data: { module: "govuk-details" }, **html_attributes) do
      safe_join([summary, description])
    end
  end

private

  def summary
    tag.summary(class: "govuk-details__summary") do
      tag.span(summary_content, class: "govuk-details__summary-text")
    end
  end

  def summary_content
    summary_html || summary_text
  end

  def description
    tag.div(class: "govuk-details__text") do
      content.presence || text
    end
  end

  def default_classes
    %w(govuk-details)
  end
end
