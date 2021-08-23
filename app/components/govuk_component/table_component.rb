class GovukComponent::TableComponent < GovukComponent::Base
  renders_one :caption, GovukComponent::TableComponent::CaptionComponent
  renders_one :head, GovukComponent::TableComponent::HeadComponent
  renders_many :bodies, GovukComponent::TableComponent::BodyComponent

  attr_accessor :id

  attr_reader :head_data, :body_data

  def initialize(id: nil, rows: nil, head: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id

    # when no rows are passed in it's likely we're taking the slot approach
    return unless rows

    @head_data, @body_data = if head
                               [head, rows]
                             else
                               [rows[0], rows[1..]]
                             end
  end

  def call
    tag.table(class: classes, **html_attributes) do
      safe_join([caption, head_content, bodies_content])
    end
  end

private

  def head_content
    head || build_head
  end

  def build_head
    return if head_data.blank?

    head(rows: [head_data])
  end

  def bodies_content
    bodies.presence || build_body
  end

  def build_body
    return if body_data.blank?

    body(rows: body_data)
  end

  def default_classes
    %w(govuk-table)
  end
end
