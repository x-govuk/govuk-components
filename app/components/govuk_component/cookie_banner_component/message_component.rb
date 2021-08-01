class GovukComponent::CookieBannerComponent::MessageComponent < GovukComponent::Base
  attr_reader :heading_text, :text, :hidden, :role

  renders_many :actions
  renders_one :heading_html

  def initialize(heading_text: nil, text: nil, hidden: false, role: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @heading_text = heading_text
    @text         = text
    @hidden       = hidden
    @role         = role
  end

  def call
    tag.div(class: classes, role: role, hidden: hidden, **html_attributes) do
      tag.div(class: "govuk-grid-row") do
        tag.div(class: "govuk-grid-column-two-thirds") do
          safe_join([heading_element, message_element, actions_element])
        end
      end
    end
  end

private

  def default_classes
    %w(govuk-cookie-banner__message govuk-width-container)
  end

  def heading_element
    tag.h2(heading_content, class: "govuk-cookie-banner__heading")
  end

  def heading_content
    heading_html || heading_text || fail(ArgumentError, "no heading_text or heading_html")
  end

  def message_element
    tag.div(message_content, class: "govuk-cookie-banner__content")
  end

  def message_content
    content || wrap_in_p(text) || fail(ArgumentError, "no text or content")
  end

  def wrap_in_p(message_text)
    return if message_text.blank?

    tag.p(message_text)
  end

  def actions_element
    return if actions.none?

    tag.div(class: "govuk-button-group") { safe_join(actions) }
  end
end
