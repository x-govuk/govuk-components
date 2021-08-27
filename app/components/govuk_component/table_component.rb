class GovukComponent::TableComponent < GovukComponent::Base
  renders_one :caption, GovukComponent::TableComponent::CaptionComponent
  renders_one :head, GovukComponent::TableComponent::HeadComponent
  renders_many :bodies, GovukComponent::TableComponent::BodyComponent

  attr_accessor :id

  def initialize(id: nil, rows: nil, head: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id

    # when no rows are passed in it's likely we're taking the slot approach
    return unless rows.presence

    build(*(head ? [head, rows] : [rows[0], rows[1..]]))
  end

private

  def build(head_data, body_data)
    head(rows: [head_data])
    body(rows: body_data)
  end

  def default_classes
    %w(govuk-table)
  end
end
