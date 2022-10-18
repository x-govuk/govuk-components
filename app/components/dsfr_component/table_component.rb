module DsfrComponent
  class TableComponent < DsfrComponent::Base
    renders_one :caption, "DsfrComponent::TableComponent::CaptionComponent"
    renders_one :head, "DsfrComponent::TableComponent::HeadComponent"
    renders_many :bodies, "DsfrComponent::TableComponent::BodyComponent"

    attr_accessor :id, :first_cell_is_header, :caption_text

    def initialize(id: nil, rows: nil, head: nil, caption: nil, first_cell_is_header: false, classes: [], html_attributes: {})
      @id                   = id
      @first_cell_is_header = first_cell_is_header
      @caption_text         = caption

      super(classes: classes, html_attributes: html_attributes)

      # when no rows are passed in it's likely we're taking the slot approach
      return unless rows.presence

      # if no head is passed in,use the first row for headers
      build(*(head ? [head, rows] : [rows[0], rows[1..]]), caption_text)
    end

  private

    def build(head_data, body_data, caption_text)
      caption(text: caption_text)
      head(rows: [head_data])
      body(rows: body_data, first_cell_is_header: first_cell_is_header)
    end

    def default_attributes
      { id: id, class: %w(govuk-table) }
    end
  end
end
