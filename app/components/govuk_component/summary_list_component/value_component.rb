class GovukComponent::SummaryListComponent::ValueComponent < GovukComponent::Base
  attr_reader :text

  def initialize(text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
  end

  def call
    tag.dd(value_content, **html_attributes)
  end

private

  def default_attributes
    { class: "#{ brand }-summary-list__value" }
  end

  def value_content
    content || text || ""
  end
end
