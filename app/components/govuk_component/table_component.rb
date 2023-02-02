module GovukComponent
  class TableComponent < GovukComponent::Base
    renders_one :caption, "GovukComponent::TableComponent::CaptionComponent"
    renders_many :cols, "GovukComponent::TableComponent::ColGroupComponent::ColComponent"
    renders_many :colgroups, "GovukComponent::TableComponent::ColGroupComponent"
    renders_one :head, "GovukComponent::TableComponent::HeadComponent"
    renders_many :bodies, "GovukComponent::TableComponent::BodyComponent"
    renders_one :foot, "GovukComponent::TableComponent::FootComponent"

    attr_accessor :id, :first_cell_is_header, :caption_text

    def initialize(id: nil, rows: nil, head: nil, foot: nil, caption: nil, first_cell_is_header: false, html_attributes: {})
      @id                   = id
      @first_cell_is_header = first_cell_is_header
      @caption_text         = caption

      super(html_attributes: html_attributes)

      # when no rows are passed in it's likely we're taking the slot approach
      return unless rows.presence

      # if no head is passed in,use the first row for headers
      build(*(head ? [head, rows] : [rows[0], rows[1..]]), foot, caption_text)
    end

    def call
      tag.table(**html_attributes) { safe_join([caption, colgroups, head, bodies, foot]) }
    end

  private

    def build(head_data, body_data, foot_data, caption_text)
      with_caption(text: caption_text)
      with_head(rows: [head_data])
      with_body(rows: body_data, first_cell_is_header: first_cell_is_header)
      with_foot(rows: foot_data, first_cell_is_header: first_cell_is_header)
    end

    def default_attributes
      { id: id, class: %w(govuk-table) }
    end
  end
end
