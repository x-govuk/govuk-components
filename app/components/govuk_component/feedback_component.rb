class GovukComponent::FeedbackComponent < GovukComponent::Base
  attr_reader :title_text, :text, :heading_level

  renders_one :header
  renders_one :body

  def initialize(title_text: nil, text: nil, heading_level: 2, classes: [], html_attributes: {})
    @title_text = title_text
    @text = text
    @heading_level = %(h#{heading_level})

    super(classes:, html_attributes:)
  end

  def call
    tag.div(**html_attributes) do
      tag.div(class: "#{brand}-grid-row") do
        tag.div(class: "#{brand}-grid-column-two-thirds") do
          safe_join([title_content, text_content])
        end
      end
    end
  end

private

  def title_content
    content = header || title_text

    fail(ArgumentError, 'title_text or header is missing') if content.blank?

    content_tag(heading_level, content, class: "#{brand}-feedback__title")
  end

  def text_content
    content = body || text

    fail(ArgumentError, 'text or body is missing') if content.blank?

    tag.div(class: "#{brand}-feedback__body") do
      tag.p(content, class: "#{brand}-body")
    end
  end

  def default_attributes
    { class: ["#{brand}-feedback", "#{brand}-width-container"] }
  end
end
