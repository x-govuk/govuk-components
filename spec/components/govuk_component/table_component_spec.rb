require 'spec_helper'

RSpec.describe(GovukComponent::TableComponent, type: :component) do
  let(:id) { 'important-table' }
  let(:component_css_class) { 'govuk-table' }
  let(:caption_text) { "What a nice table" }
  let(:head) { %w(one two) }
  let(:body) { %w(three four) }

  let(:kwargs) { { id: id } }

  subject! do
    render_inline(GovukComponent::TableComponent.new(**kwargs)) do |table|
      table.caption(text: "What a nice table")

      table.thead do |thead|
        thead.row do
          # header cells
        end
      end

      table.tbody do |tbody|
        tbody.row do
          # row one cells
        end
      end
    end
  end

  specify "renders a table with thead and tbody elements" do
    expect(rendered_component).to have_tag("table.govuk-table")
  end

  specify "renders a caption" do
    expect(rendered_component).to have_tag("table", with: { class: component_css_class }) do
      with_tag("caption", text: caption_text)
    end
  end

  specify "renders a thead element" do
    expect(rendered_component).to have_tag("table > thead")
  end

  specify "renders a tbody element" do
    expect(rendered_component).to have_tag("table > tbody")
  end

  context "when the rows are passed in as a multidimensional array" do
    context "of arrays" do
      context "when the first row contains headers and there are three rows of data" do
        let(:rows) do
          [
            %w(header-col-1 header-col-2 header-col-3 header-col-4),
            %w(row-1-col-1 row-1-col-2 row-1-col-3 row-1-col-4),
            %w(row-2-col-1 row-2-col-2 row-2-col-3 row-2-col-4),
            %w(row-3-col-1 row-3-col-2 row-3-col-3 row-3-col-4),
          ]
        end

        subject! do
          render_inline(GovukComponent::TableComponent.new(**kwargs.merge(rows: rows)))
        end

        specify "renders one header row" do
          expect(rendered_component).to have_tag("table", with: { class: component_css_class }) do
            with_tag("thead", with: { class: "govuk-table__head" }) do
              with_tag("tr", with: { class: "govuk-table__row" }, count: 1)
            end
          end
        end

        specify "renders three body rows" do
          expect(rendered_component).to have_tag("table", with: { class: component_css_class }) do
            with_tag("tbody", with: { class: "govuk-table__body" }) do
              with_tag("tr", with: { class: "govuk-table__row" }, count: 3)
            end
          end
        end

        specify "the head contains the right columns"
        specify "the rows contain the right contents"
      end

      context "when headers are passed in separately" do
        let(:head) do
          %w(header-col-1 header-col-2 header-col-3 header-col-4)
        end

        let(:rows) do
          [
            %w(row-1-col-1 row-1-col-2 row-1-col-3 row-1-col-4),
            %w(row-2-col-1 row-2-col-2 row-2-col-3 row-2-col-4),
            %w(row-3-col-1 row-3-col-2 row-3-col-3 row-3-col-4),
          ]
        end

        specify "renders one header row and three body rows"
        specify "the head contains the right columns"
        specify "the rows contain the right contents"
      end
    end
  end

  context "when the rows are built using nested slots" do
  end

  describe "customising the caption size" do
    %w(s m l xl)
      .each
      .with_object({}) { |size, h| h[size] = "govuk-table__caption--#{size}" }
      .each do |size, expected_class|
        context "when #{size}" do
          let(:size) { size }

          subject do
            render_inline(GovukComponent::TableComponent.new(**kwargs)) do |table|
              table.caption(text: "Caption size: #{size}", size: size)
            end
          end

          specify "class '#{expected_class} is added" do
            expect(rendered_component).to have_tag('caption', with: { class: ["govuk-table__caption", "govuk-table__caption--#{size}"] })
          end
        end
      end
  end
end
