class GovukComponent::PanelComponent < GovukComponent::Base
  attr_reader :title, :body

  def initialize(title: nil, body: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @title = title
    @body  = body
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
    tag.h1(title, class: "govuk-panel__title") if display_title?
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
