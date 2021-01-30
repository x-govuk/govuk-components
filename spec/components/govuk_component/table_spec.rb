require 'spec_helper'

RSpec.shared_examples("table") do
  specify "generates a table with correct GOV.UK Design Systme classes" do
    expect(page).to have_css(".govuk-table > .govuk-table__head > .govuk-table__row > .govuk-table__header")
    expect(page).to have_css(".govuk-table > .govuk-table__body > .govuk-table__row > .govuk-table__cell")
  end

  specify "renders the correct headings" do
    expected_column_titles.each do |column_title|
      expect(page).to have_css("table > thead > tr > th", text: column_title)
    end
  end

  specify "renders one row per data item" do
    expect(page).to have_css("tbody > tr", count: data.size)
  end

  specify "places data in the correct cells" do
    expected_table_contents.each.with_index do |row, i|
      expect(page.all("tbody > tr").at(i).all("td").map(&:text)).to eql(row)
    end
  end
end

RSpec.describe(GovukComponent::Accordion, type: :component) do
  # test table format:
  #
  # | Column B | Column B | Column C |
  # | -------- | -------- | -------- |
  # | one_a    | one_b    | one_c    |
  # | two_a    | two_b    | two_c    |
  # | three_a  | three_b  | three_c  |

  describe "when data is an array of arrays" do
    context "when headings and data are provided" do
      let(:headings) { ["Column A", "Column B", "Column C"] }
      let(:data) do
        [
          %w(one_a one_b one_c),
          %w(two_a two_b two_c),
          %w(three_a three_b three_c)
        ]
      end

      subject! do
        render_inline(GovukComponent::Table.new(data: data, headings: headings))
      end

      include_examples("table") do
        let(:expected_column_titles) { headings }
        let(:expected_table_contents) { data }
      end
    end

    context "when non-array headings are provided" do
      let(:data) { [] }
      let(:headings) { { foo: "bar" } }

      specify "should raise an error informing me that headings must be in an array" do
        expect { GovukComponent::Table.new(data: data, headings: headings) }.to raise_error(ArgumentError, /must be an array/)
      end
    end
  end

  describe "when data is a hash" do
    context "when headings and data are provided" do
      let(:headings) { { column_a: "Column A", column_b: "Column B", column_c: "Column C" } }
      let(:data) do
        [
          { column_a: "one_a", column_b: "one_b", column_c: "one_c" },
          { column_a: "two_a", column_b: "two_b", column_c: "two_c" },
          { column_a: "three_a", column_b: "three_b", column_c: "three_c" }
        ]
      end

      subject! do
        render_inline(GovukComponent::Table.new(data: data, headings: headings))
      end

      include_examples("table") do
        let(:expected_column_titles) { headings.values }
        let(:expected_table_contents) { data.map(&:values) }
      end
    end
  end

  describe "when data is some objects" do
    context "when headings and data are provided" do
      SampleModel = Struct.new(:value_a, :value_b, :value_c, keyword_init: true)

      let(:headings) { { value_a: "Column A", value_b: "Column B", value_c: "Column C" } }
      let(:data) do
        [
          SampleModel.new(value_a: "one_a", value_b: "one_b", value_c: "one_c"),
          SampleModel.new(value_a: "two_a", value_b: "two_b", value_c: "two_c"),
          SampleModel.new(value_a: "three_a", value_b: "three_b", value_c: "three_c")
        ]
      end

      subject! do
        render_inline(GovukComponent::Table.new(data: data, headings: headings))
      end

      include_examples("table") do
        let(:expected_column_titles) { headings.values }
        let(:expected_table_contents) { data.map { |r| [r.value_a, r.value_b, r.value_c] } }
      end
    end
  end
end
