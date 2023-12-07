class GovukComponent::SummaryListComponent::ActionComponent < GovukComponent::Base
  attr_reader :href, :text, :visually_hidden_text, :attributes, :classes, :card_title

  def initialize(href: nil, text: 'Change', visually_hidden_text: false, classes: [], html_attributes: {}, card_title: nil)
    @visually_hidden_text = visually_hidden_text

    if config.require_summary_list_action_visually_hidden_text && visually_hidden_text == false
      fail(ArgumentError, "missing keyword: visually_hidden_text")
    end

    super(classes: classes, html_attributes: html_attributes)

    @href = href
    @text = text
    @card_title = card_title
  end

  def render?
    href.present?
  end

  def call
    link_to(href, **html_attributes) do
      safe_join([action_text, visually_hidden_span].compact)
    end
  end

private

  def default_attributes
    link_classes = safe_join([govuk_link_classes, classes], " ")

    { class: link_classes }
  end

  def action_text
    content || text || fail(ArgumentError, "no text or content")
  end

  def visually_hidden_span
    if visually_hidden_text.present? || card_title.present?
      tag.span(%( #{visually_hidden_text}), class: "#{brand}-visually-hidden") do
        " " + visually_hidden_text + (card_title.present? ? " (" + card_title + ")" : "")
      end
    end
  end
end
