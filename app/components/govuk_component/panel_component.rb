class GovukComponent::PanelComponent < GovukComponent::Base
  attr_reader :title, :body, :heading_level

  def initialize(title: nil, body: nil, heading_level: 1, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @heading_level = heading_level
    @title         = title
    @body          = body
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

  def display_title?
    title.present?
  end

  def display_body?
    body.present? || content.present?
  end

  def panel_title
    content_tag(heading_tag, title, class: "govuk-panel__title") if display_title?
  end

  def heading_tag
    "h#{heading_level}"
  end

  def panel_body
    if display_body?
      tag.div(class: "govuk-panel__body") do
        content.presence || body
      end
    end
  end

  def render?
    display_title? || display_body?
  end
end
