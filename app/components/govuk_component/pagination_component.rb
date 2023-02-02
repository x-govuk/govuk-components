class GovukComponent::PaginationComponent < GovukComponent::Base
  include Pagy::UrlHelpers

  attr_reader :pagy,
              :next_text,
              :previous_text,
              :page_items,
              :previous_content,
              :next_content,
              :block_mode,
              :landmark_label

  alias_method :block_mode?, :block_mode

  renders_many :items, "GovukComponent::PaginationComponent::Item"

  renders_one :next_page, ->(href:, text: default_adjacent_text(:next), label_text: nil, html_attributes: {}) do
    GovukComponent::PaginationComponent::NextPage.new(
      text: text,
      href: href,
      label_text: label_text,
      block_mode: block_mode?,
      html_attributes: html_attributes
    )
  end

  renders_one :previous_page, ->(href:, text: default_adjacent_text(:prev), label_text: nil, html_attributes: {}) do
    GovukComponent::PaginationComponent::PreviousPage.new(
      text: text,
      href: href,
      label_text: label_text,
      block_mode: block_mode?,
      html_attributes: html_attributes
    )
  end

  def initialize(pagy: nil,
                 next_text: nil,
                 previous_text: nil,
                 block_mode: false,
                 landmark_label: config.default_pagination_landmark_label,
                 html_attributes: {})
    @pagy                          = pagy
    @next_text                     = next_text
    @previous_text                 = previous_text
    @block_mode                    = block_mode
    @landmark_label                = landmark_label

    super(html_attributes: html_attributes)
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
    }

    with_previous_page(**kwargs.compact)
  end

  def build_next
    return unless pagy&.next

    kwargs = {
      href: pagy_url_for(pagy, pagy.next),
      text: @next_text,
    }

    with_next_page(**kwargs.compact)
  end

  def build_items
    pagy.series.map { |i| with_item(number: i, href: pagy_url_for(pagy, i), from_pagy: true) }
  end

  def default_adjacent_text(side)
    visible, hidden = *case side
                       when :next
                         config.default_pagination_next_text
                       when :prev
                         config.default_pagination_previous_text
                       end

    return visible if hidden.blank?

    (visible + tag.span(" #{hidden}", class: "govuk-visually-hidden")).html_safe
  end
end
