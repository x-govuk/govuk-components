class GovukComponent::SummaryListComponent::ActionComponent < GovukComponent::Base
  class VisuallyHiddenDefaultNilClass < NilClass; end

  attr_reader :href, :text, :visually_hidden_text, :attributes, :classes

  def initialize(href: nil, text: 'Change', visually_hidden_text: VisuallyHiddenDefaultNilClass, classes: [], html_attributes: {})
    if config.require_summary_list_action_visually_hidden_text && visually_hidden_text == VisuallyHiddenDefaultNilClass
      fail(ArgumentError, "missing keyword: visually_hidden_text")
    end

    super(classes: classes, html_attributes: html_attributes)

    @href                 = href
    @text                 = text
    @visually_hidden_text = visually_hidden_text
  end

  def render?
    href.present?
  end

  def call
    link_to(href, **html_attributes) do
      safe_join([action_text, visually_hidden_span].compact, " ")
    end
  end

private

  def default_attributes
    link_classes = govuk_link_classes.append(classes).flatten

    { class: link_classes }
  end

  def action_text
    content || text || fail(ArgumentError, "no text or content")
  end

  def visually_hidden_span
    tag.span(visually_hidden_text, class: "govuk-visually-hidden") if visually_hidden_text.present?
  end
end
