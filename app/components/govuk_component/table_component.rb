class GovukComponent::TableComponent < GovukComponent::Base
  renders_one :caption, GovukComponent::TableComponent::CaptionComponent
  renders_one :head, GovukComponent::TableComponent::HeadComponent
  renders_many :bodies, GovukComponent::TableComponent::BodyComponent

  attr_accessor :id

  def initialize(id: nil, rows: nil, head: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id

    # when no rows are passed in it's likely we're taking the slot approach
    return unless rows

    head_data, body_data = if head
                             [head, rows]
                           else
                             [rows[0], rows[1..]]
                           end


    build_head_from_head_data(head_data)
    build_body_from_body_data(body_data)
  end

private

  def build_head_from_head_data(data)
    head(rows: [data])
  end

  def build_body_from_body_data(data)
    body(rows: data)
  end

  def default_classes
    %w(govuk-table)
  end
end
