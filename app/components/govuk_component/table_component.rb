class GovukComponent::TableComponent < GovukComponent::Base
  renders_one :caption, GovukComponent::TableComponent::CaptionComponent
  renders_one :thead, GovukComponent::TableComponent::HeadComponent
  renders_one :tbody, GovukComponent::TableComponent::BodyComponent

  attr_accessor :id

  def initialize(id: nil, rows: nil, head: nil, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id = id

    # when no rows are passed in it's likely we're taking the slot approach
    return unless rows

    @head_data, @row_data = if head
                              [head, rows]
                            else
                              [rows[0], rows[1..]]
                            end
  end

  def call
    tag.table(class: classes, **html_attributes) do
      safe_join([caption, thead])
    end
  end

private

  def build_thead(table)
    # TODO
  end

  def build_tbody(table)
    # TODO
  end

  def default_classes
    %w(govuk-table)
  end
end
