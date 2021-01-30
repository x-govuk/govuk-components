class GovukComponent::Table < GovukComponent::Base
  attr_accessor :data

  def initialize(data:, headings:, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @data = if data.all? { |r| r.is_a?(Array) }
              DataArrays.new(data, headings)
            elsif data.all? { |r| r.is_a?(Hash) }
              DataHashes.new(data, headings)
            else
              DataObjects.new(data, headings)
            end
  end

  def call
    tag.table(class: "govuk-table") do
      safe_join(
        [
          tag.thead(class: "govuk-table__head") { build_column_heading_row(data.columns) },
          tag.tbody(class: "govuk-table__body") { safe_join(data.rows.map { |row| build_data_row(row) }) }
        ]
      )
    end
  end

private

  def default_classes
    %w(govuk-table)
  end

  def build_column_heading_row(headings)
    build_row(:th, headings, "govuk-table__header")
  end

  def build_data_row(values)
    build_row(:td, values, "govuk-table__cell")
  end

  def build_row(cell, values, classes)
    tag.tr(class: "govuk-table__row") do
      safe_join(values.map { |v| content_tag(cell, v, class: classes) })
    end
  end

  class DataArrays
    attr_accessor :rows, :columns

    def initialize(data, columns)
      @rows = data

      # TODO: must have the same number of elements
      fail(ArgumentError, "headings must be an array when data contains arrays") unless columns.is_a?(Array)

      @columns = columns
      # TODO: must match the number of data elements
    end
  end

  class DataHashes
    attr_accessor :rows, :columns

    def initialize(data, columns)
      @columns = columns.values
      @rows = data.map { |r| columns.keys.map { |k| r.fetch(k) } }
    end
  end

  class DataObjects
    attr_accessor :rows, :columns

    def initialize(data, columns)
      @columns = columns.values
      @rows = data.map { |r| columns.keys.map { |k| r.send(k) } }
    end
  end
end
