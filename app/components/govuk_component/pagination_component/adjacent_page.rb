class GovukComponent::PaginationComponent::AdjacentPage < GovukComponent::Base
  attr_reader :href, :label_text, :text, :suffix, :block_mode, :visually_hidden_text
  alias_method :block_mode?, :block_mode

  def initialize(href:, suffix:, visually_hidden_text:, text:, block_mode: true, label_text: nil, classes: [], html_attributes: {})
    @href                 = href
    @label_text           = label_text
    @text                 = text
    @block_mode           = block_mode
    @suffix               = suffix
    @visually_hidden_text = visually_hidden_text

    super(html_attributes: html_attributes, classes: classes)
  end

  def call
    tag.div(**html_attributes) do
      tag.a(href: href, class: %w(govuk-link govuk-pagination__link), rel: suffix, aria: { label: aria_label }) do
        safe_join([body, divider, label_content])
      end
    end
  end

private

  def default_attributes
    { class: ["govuk-pagination__#{suffix}"] }
  end

  def body
    [arrow, title_span]
  end

  def title_span
    tag.span(text, class: title_classes)
  end

  def divider
    return if label_text.blank?

    tag.span(":", class: %w(govuk-visually-hidden))
  end

  def label_content
    return if label_text.blank?

    tag.span(label_text, class: label_classes)
  end

  def title_classes
    class_names(
      %(govuk-pagination__link-title),
      %(govuk-pagination__link-title--decorated) => label_text.blank?
    )
  end

  def label_classes
    %w(govuk-pagination__link-label)
  end
end
