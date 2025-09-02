class GovukComponent::SummaryListComponent::ActionComponent < GovukComponent::Base
  include GovukLinkHelper
  include GovukVisuallyHiddenHelper

  attr_reader :href, :text, :visually_hidden_text, :visually_hidden_action_suffix, :attributes, :classes

  def initialize(href: nil, text: 'Change', visually_hidden_text: false, visually_hidden_action_suffix: nil, classes: [], html_attributes: {})
    @visually_hidden_text = visually_hidden_text

    if config.require_summary_list_action_visually_hidden_text && visually_hidden_text == false
      fail(ArgumentError, "missing keyword: visually_hidden_text")
    end

    super(classes:, html_attributes:)
    @href = href
    @text = text
    @visually_hidden_action_suffix = visually_hidden_action_suffix
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

  def visually_hidden_content
    return "#{visually_hidden_text} (#{visually_hidden_action_suffix})" if visually_hidden_action_suffix

    visually_hidden_text
  end

  def visually_hidden_span
    tag.span(%( #{visually_hidden_content}), class: "#{brand}-visually-hidden") if visually_hidden_text.present?
  end
end
