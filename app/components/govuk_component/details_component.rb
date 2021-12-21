class GovukComponent::DetailsComponent < GovukComponent::Base
  attr_reader :summary_text, :text, :id, :open

  renders_one :summary_html

  def initialize(summary_text: nil, text: nil, classes: [], id: nil, open: nil, html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @summary_text = summary_text
    @text         = text
    @id           = id
    @open         = open
  end

  def call
    tag.details(class: classes, data: { module: "govuk-details" }, id: id, open: open, **html_attributes) do
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
