class GovukComponent::PaginationComponent < GovukComponent::Base
  include Pagy::UrlHelpers

  attr_reader :pagy,
              :next_text,
              :previous_text,
              :visually_hidden_next_text,
              :visually_hidden_previous_text,
              :page_items,
              :previous_content,
              :next_content,
              :block_mode,
              :landmark_label

  alias_method :block_mode?, :block_mode

  renders_many :items, "GovukComponent::PaginationComponent::Item"

  renders_one :next_page, ->(href:, text: default_next_text, label_text: nil, visually_hidden_text: nil, classes: [], html_attributes: {}) do
    GovukComponent::PaginationComponent::NextPage.new(
      text: text,
      href: href,
      label_text: label_text,
      block_mode: block_mode?,
      visually_hidden_text: visually_hidden_text,
      classes: classes,
      html_attributes: html_attributes
    )
  end

  renders_one :previous_page, ->(href:, text: default_previous_text, label_text: nil, visually_hidden_text: nil, classes: [], html_attributes: {}) do
    GovukComponent::PaginationComponent::PreviousPage.new(
      text: text,
      href: href,
      label_text: label_text,
      block_mode: block_mode?,
      visually_hidden_text: visually_hidden_text,
      classes: classes,
      html_attributes: html_attributes
    )
  end

  def initialize(pagy: nil, next_text: nil, previous_text: nil, visually_hidden_next_text: nil, visually_hidden_previous_text: nil, block_mode: false, landmark_label: "results", classes: [], html_attributes: {})
    @pagy                          = pagy
    @next_text                     = next_text
    @previous_text                 = previous_text
    @visually_hidden_next_text     = visually_hidden_next_text
    @visually_hidden_previous_text = visually_hidden_previous_text
    @block_mode                    = block_mode
    @landmark_label                = landmark_label

    super(classes: classes, html_attributes: html_attributes)
  end

  def before_render
    @page_items = if pagy.present?
                    build_items
                  elsif items.any?
                    items
                  else
                    []
                  end

    @previous_content = previous_page || build_previous
    @next_content     = next_page || build_next
  end

  def call
    attributes = html_attributes.tap { |ha| (ha[:class] << "govuk-pagination--block") if items.empty? }

    tag.nav(**attributes) do
      safe_join([
        previous_content,
        tag.ul(class: "govuk-pagination__list") { safe_join(page_items) },
        next_content
      ])
    end
  end

  def render?
    # probably isn't any point rendering if there's only one page
    (pagy.present? && pagy.series.size > 1) || @previous_content.present? || @next_content.present?
  end

private

  def default_attributes
    { role: "navigation", aria: { label: landmark_label }, class: %w(govuk-pagination) }
  end

  def build_previous
    return unless pagy&.prev

    kwargs = {
      href: pagy_url_for(pagy, pagy.prev),
      text: @previous_text,
      visually_hidden_text: visually_hidden_previous_text,
    }

    previous_page(**kwargs.compact)
  end

  def build_next
    return unless pagy&.next

    kwargs = {
      href: pagy_url_for(pagy, pagy.next),
      text: @next_text,
      visually_hidden_text: visually_hidden_next_text,
    }

    next_page(**kwargs.compact)
  end

  def build_items
    pagy.series.map { |i| item(number: i, href: pagy_url_for(pagy, i), from_pagy: true) }
  end

  def default_next_text
    safe_join(["Next", tag.span(class: "govuk-visually-hidden") { " page" }])
  end

  def default_previous_text
    safe_join(["Previous", tag.span(class: "govuk-visually-hidden") { " page" }])
  end
end
