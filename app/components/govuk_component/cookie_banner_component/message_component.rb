class GovukComponent::CookieBannerComponent::MessageComponent < GovukComponent::Base
  attr_reader :heading_text, :text, :hidden, :role

  renders_many :actions
  renders_one :heading_html

  def initialize(heading_text: nil, text: nil, hidden: false, role: nil, classes: [], html_attributes: {})
    @heading_text = heading_text
    @text         = text
    @hidden       = hidden
    @role         = role

    super(classes:, html_attributes:)
  end

  def call
    tag.div(role:, hidden:, **html_attributes) do
      safe_join([
        tag.div(class: "#{brand}-grid-row") do
          tag.div(class: "#{brand}-grid-column-two-thirds") { safe_join([heading_element, message_element]) }
        end,
        actions_element
      ])
    end
  end

private

  def default_attributes
    { class: "#{brand}-cookie-banner__message #{brand}-width-container" }
  end

  def heading_element
    return if heading_content.blank?

    tag.h2(heading_content, class: "#{brand}-cookie-banner__heading #{brand}-heading-m")
  end

  def heading_content
    heading_html || heading_text
  end

  def message_element
    tag.div(message_content, class: "#{brand}-cookie-banner__content")
  end

  def message_content
    content || wrap_in_p(text) || fail(ArgumentError, "no text or content")
  end

  def wrap_in_p(message_text)
    return if message_text.blank?

    tag.p(message_text, class: "#{brand}-body")
  end

  def actions_element
    return if actions.none?

    tag.div(class: "#{brand}-button-group") { safe_join(actions) }
  end
end
