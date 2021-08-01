class GovukComponent::SummaryListComponent::ActionComponent < GovukComponent::Base
  attr_reader :href, :text, :visually_hidden_text, :attributes, :classes

  def initialize(href: nil, text: 'Change', visually_hidden_text: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @href                 = href
    @text                 = text
    @visually_hidden_text = visually_hidden_text
  end

  def call
    # when no href is provided return an empty string so the dd container
    # will render, it's useful in lists where some rows have actions
    # and others don't
    return "" if href.blank?

    link_classes = govuk_link_classes.append(classes).flatten

    link_to(href, class: link_classes, **html_attributes) do
      safe_join([action_text, visually_hidden_span])
    end
  end

private

  def action_text
    content || text || fail(ArgumentError, "no text or content")
  end

  def visually_hidden_span
    tag.span(visually_hidden_text, class: "govuk-visually-hidden") if visually_hidden_text.present?
  end
end
