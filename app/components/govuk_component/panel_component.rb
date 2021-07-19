class GovukComponent::PanelComponent < GovukComponent::Base
  attr_reader :title_text, :text, :heading_level

  renders_one :title_html

  def initialize(title_text: nil, text: nil, heading_level: 1, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @heading_level = heading_level
    @title_text    = title_text
    @text          = text
  end

  def call
    tag.div(class: classes, **html_attributes) do
      safe_join([panel_title, panel_body].compact)
    end
  end

private

  def default_classes
    %w(govuk-panel govuk-panel--confirmation)
  end

  def heading_tag
    "h#{heading_level}"
  end

  def panel_content
    content || text
  end

  def title
    title_html || title_text
  end

  def panel_title
    return if title.blank?

    content_tag(heading_tag, title, class: "govuk-panel__title")
  end

  def panel_body
    return if panel_content.blank?

    tag.div(class: "govuk-panel__body") do
      panel_content
    end
  end

  def render?
    title.present? || panel_content.present?
  end
end
