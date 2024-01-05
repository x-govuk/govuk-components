require 'pagy'

# We need this here because the pagy helpers we're using to build
# links expect a Rack request.
module Pagy::UrlHelpers
  def request
    OpenStruct.new(GET: {}, session: nil, host: "https://somesite/", format: OpenStruct.new(html?: true))
  end
end

module Examples
  module PaginationHelpers
    def pagination_normal
      <<~PAGINATION
        = govuk_pagination(pagy: pagy)
      PAGINATION
    end

    def pagination_normal_data
      <<~PAGINATION_DATA
        { pagy: Pagy.new(count: 100, page: 2) }
      PAGINATION_DATA
    end

    def pagination_lots_of_pages
      <<~PAGINATION
        = govuk_pagination(pagy: pagy)
      PAGINATION
    end

    def pagination_lots_of_pages_data
      <<~PAGINATION_DATA
        { pagy: Pagy.new(count: 100, page: 9, size: [1, 1, 1, 1], items: 5) }
      PAGINATION_DATA
    end

    def pagination_vertical
      <<~PAGINATION
        = govuk_pagination(block_mode: true) do |p|
          - p.with_previous_page(text: "Chapter 3", label_text: "Edmund and the Wardrobe", href: "#")
          - p.with_next_page(text: "Chapter 5", label_text: "Back on This Side of the Door", href: "#")
      PAGINATION
    end

    def manual_pagination_items
      <<~PAGINATION_DATA
        {
          item_data:
            [
              { href: "#", number: 10, html_attributes: { id: 'page-10' } },
              { ellipsis: true },
              { href: "#", number: 20, html_attributes: { id: 'page-20' } },
              { ellipsis: true },
              { href: "#", number: 30, current: true, html_attributes: { id: 'page-30' } },
              { ellipsis: true },
              { href: "#", number: 40, html_attributes: { id: 'page-40' } },
            ]
        }
      PAGINATION_DATA
    end

    def pagination_manual
      <<~PAGINATION
        = govuk_pagination do |p|
          - p.with_previous_page(href: "#", text: "Previous events", html_attributes: { id: 'page-prev' })
          - p.with_items(item_data)
          - p.with_next_page(href: "#", text: "Next events", html_attributes: { id: 'page-next' })
      PAGINATION
    end
  end
end
