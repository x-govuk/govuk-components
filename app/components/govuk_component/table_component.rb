class GovukComponent::TableComponent < GovukComponent::Base
  renders_one :caption, GovukComponent::TableComponent::CaptionComponent
  renders_one :thead, GovukComponent::TableComponent::HeadComponent
  renders_one :tbody, GovukComponent::TableComponent::BodyComponent

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
      safe_join([caption, thead_content, tbody_content])
    end
  end

private

  def thead_content
    thead || build_thead
  end

  def build_thead
    return if head_data.blank?

    thead(rows: [head_data])
  end

  def tbody_content
    tbody || build_tbody
  end

  def build_tbody
    return if body_data.blank?

    tbody(rows: body_data)
  end

  def default_classes
    %w(govuk-table)
  end
end
