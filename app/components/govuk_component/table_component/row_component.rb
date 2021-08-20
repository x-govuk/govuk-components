class GovukComponent::TableComponent::RowComponent < GovukComponent::Base
  renders_many :data_cells   # td
  renders_many :header_cells # th

  def initialize(cells:)
    # TODO
  end

private

  def default_classes
    %w(govuk-table__row)
  end
end
