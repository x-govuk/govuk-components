require 'spec_helper'

RSpec.describe(GovukComponent::TableComponent, type: :component) do
  let(:id) { 'important-table' }
  let(:component_css_class) { 'govuk-table' }
  let(:caption_text) { "What a nice table" }

  let(:kwargs) { { id: } }

  subject! do
    render_inline(GovukComponent::TableComponent.new(**kwargs)) do |table|
      table.with_caption(text: "What a nice table")

      table.with_head do |head|
        head.with_row do |row|
          row.with_cell(text: "A")
          row.with_cell(text: "B")
        end
      end

      table.with_body do |body|
        body.with_row do |row|
          row.with_cell(text: "C")
          row.with_cell(text: "D")
        end
      end
    end
  end

  specify "renders a table with thead and tbody elements" do
    expect(rendered_content).to have_tag("table", with: { class: "govuk-table" }) do
      with_tag('thead', with: { class: "govuk-table__head" })
      with_tag('tbody', with: { class: "govuk-table__body" })
    end
  end

  specify "table has the provided id" do
    expect(rendered_content).to have_tag("table", with: { id: })
  end

  specify "renders a thead element" do
    expect(rendered_content).to have_tag("table > thead")
  end

  specify "the cells in thead should default to th" do
    expect(rendered_content).to have_tag("table > thead > tr > th", count: 2)
  end

  specify "renders a tbody element" do
    expect(rendered_content).to have_tag("table > tbody")
  end

  specify "the cells in tbody should default to td" do
    expect(rendered_content).to have_tag("table > tbody > tr > td", count: 2)
  end

  context "when there is more than one tbody" do
    let(:expected_count) { 2 }

    subject! do
      render_inline(GovukComponent::TableComponent.new(**kwargs)) do |table|
        table.with_caption(text: "What a nice table")

        expected_count.times { table.with_body {} }
      end
    end

    specify "mutiple tbody elements are rendered" do
      expect(rendered_content).to have_tag("table > tbody", count: expected_count)
    end
  end

  describe "passing data directly into the table component" do
    describe "captions" do
      let(:rows) { [%w(a b c), %w(d e f)] }

      context "when the caption is passed in as an argument" do
        let(:caption_text) { "Argument-supplied caption" }

        subject! do
          render_inline(GovukComponent::TableComponent.new(**kwargs.merge(rows:, caption: caption_text)))
        end

        specify "renders the caption with the provided text" do
          expect(rendered_content).to have_tag("table") do
            with_tag("caption", text: caption_text)
          end
        end
      end

      context "when no caption is passed in" do
        let(:caption_text) { nil }

        subject! do
          render_inline(GovukComponent::TableComponent.new(**kwargs.merge(rows:, caption: caption_text)))
        end

        specify "renders no caption element" do
          expect(rendered_content).to have_tag("table") do
            without_tag("caption")
          end
        end
      end
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

          let(:body_rows) { rows[1..] }

          subject! do
            render_inline(GovukComponent::TableComponent.new(**kwargs.merge(rows:)))
          end

          specify "renders one header row" do
            expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
              with_tag("thead", with: { class: "govuk-table__head" }) do
                with_tag("tr", with: { class: "govuk-table__row" }, count: 1)
              end
            end
          end

          specify "renders three body rows" do
            expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
              with_tag("tbody", with: { class: "govuk-table__body" }) do
                with_tag("tr", with: { class: "govuk-table__row" }, count: 3)
              end
            end
          end
        end

        context "when there are three rows of data and the head and foot are passed in separately" do
          let(:head) do
            %w(head-col-1 head-col-2 head-col-3 head-col-4)
          end

          let(:rows) do
            [
              %w(row-1-col-1 row-1-col-2 row-1-col-3 row-1-col-4),
              %w(row-2-col-1 row-2-col-2 row-2-col-3 row-2-col-4),
              %w(row-3-col-1 row-3-col-2 row-3-col-3 row-3-col-4),
            ]
          end

          let(:foot) do
            %w(foot-col-1 foot-col-2 foot-col-3 foot-col-4)
          end

          subject! do
            render_inline(GovukComponent::TableComponent.new(**kwargs.merge(head:, rows:, foot:)))
          end

          specify "renders one thead row" do
            expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
              with_tag("thead", with: { class: "govuk-table__head" }) do
                with_tag("tr", with: { class: "govuk-table__row" }, count: 1) do
                  head.all? { |text| with_tag("th", text:, with: { class: "govuk-table__header" }) }
                end
              end
            end
          end

          specify "renders three body rows" do
            expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
              with_tag("tbody", with: { class: "govuk-table__body" }) do
                with_tag("tr", with: { class: "govuk-table__row" }, count: 3) do
                  rows.flatten.all? { |text| with_tag("td", text:, with: { class: "govuk-table__cell" }) }
                end
              end
            end
          end

          specify "renders one tfoot row" do
            expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
              with_tag("tfoot", with: { class: "govuk-table__foot" }) do
                with_tag("tr", with: { class: "govuk-table__row" }, count: 1) do
                  foot.all? { |text| with_tag("td", text:, with: { class: "govuk-table__footer" }) }
                end
              end
            end
          end
        end
      end

      context "of hashes with a numeric column" do
        let(:head) do
          [{ text: "head-col-1", scope: false, html_attributes: { id: "scopeless" } }, { text: "head-col-2", numeric: true }]
        end

        let(:rows) do
          [
            [{ text: "body-row-1-col-1" }, { text: 2, numeric: true }],
            [{ text: "body-row-2-col-1" }, { text: 3, numeric: false }],
          ]
        end

        let(:foot) do
          [{ text: "foot-col-1" }, { text: 4, numeric: true }]
        end

        subject! do
          render_inline(
            GovukComponent::TableComponent.new(
              first_cell_is_header: true,
              head:,
              rows:,
              foot:
            )
          )
        end

        specify "renders a thead with a non-numeric and numeric column" do
          expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
            with_tag("thead", with: { class: "govuk-table__head" }, count: 1) do
              with_tag("tr", with: { class: "govuk-table__row" }, count: 1) do
                with_tag("th", text: "head-col-1", with: { class: %w(govuk-table__header) })
                with_tag("th", text: "head-col-2", with: { class: %w(govuk-table__header govuk-table__header--numeric) })
              end
            end
          end
        end

        specify "we can set HTML attributes using 'html_attributes: {}' and scope can be suppressed with 'scope: false'" do
          html.at_css("#scopeless").attributes.keys.tap do |attributes|
            expect(attributes).not_to include("scope")
            expect(attributes).to match_array(%w(id class))
          end
        end

        specify "renders a tbody with the right number of rows and correct content" do
          expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
            with_tag("tbody", with: { class: "govuk-table__body" }, count: 1) do
              with_tag("tr", with: { class: "govuk-table__row" }, count: 2) do
                with_tag("th", text: "body-row-1-col-1", with: { class: %w(govuk-table__header), scope: "row" })
                with_tag("td", text: "2", with: { class: %w(govuk-table__cell govuk-table__cell--numeric) })

                # the row with 3 in it is 'numeric: false'
                with_tag("td", text: "3", with: { class: %w(govuk-table__cell) })
                without_tag("td", text: "3", with: { class: %w(govuk-table__cell--numeric) })
              end
            end
          end
        end

        specify "renders a tfoot with a non-numeric and numeric column" do
          expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
            with_tag("tfoot", with: { class: "govuk-table__foot" }, count: 1) do
              with_tag("tr", with: { class: "govuk-table__row" }, count: 1) do
                with_tag("th", text: "foot-col-1", with: { class: %w(govuk-table__footer) })
                without_tag("th", with: { class: %w(govuk-table__header) })
                with_tag("td", text: "4", with: { class: %w(govuk-table__footer govuk-table__footer--numeric) })
              end
            end
          end
        end
      end
    end

    context "when :first_cell_is_header is true" do
      let(:number_of_rows) { 3 }
      let(:row_header_text) { 'should be a header' }
      let(:row_cell_text) { 'should be a regular cell' }

      let(:head) { %w(header-col-1 header-col-2 header-col-3) }
      let(:rows) do
        number_of_rows.times.map { [row_header_text, row_cell_text, row_cell_text] }
      end

      subject! do
        render_inline(GovukComponent::TableComponent.new(**kwargs.merge(head:, rows:, first_cell_is_header: true)))
      end

      specify "renders the table header" do
        expect(rendered_content).to have_tag("table > thead") do
          head.each do |heading|
            with_tag('th', text: heading, with: { class: 'govuk-table__header', scope: 'col' })
          end
        end
      end

      specify "renders the header column in table body cells" do
        expect(rendered_content).to have_tag("table > tbody") do
          with_tag('th', text: row_header_text, count: number_of_rows, with: { scope: 'row' })
          with_tag('td', text: row_cell_text, count: number_of_rows * 2)
        end
      end

      specify "the header is always first" do
        html.css('tbody > tr').map(&:elements).each { |r| expect(r.first.name).to eql('th') }
      end

      specify "all header cells in the tbody have a scope but no data cells do" do
        attributes_per_element_type = %w(th td).each.with_object({}) do |element, h|
          h[element] = html.css(element).map(&:attributes).map(&:keys)
        end

        expect(attributes_per_element_type["th"]).to all(eql(%w(class scope)))
        expect(attributes_per_element_type["td"]).to all(eql(%w(class)))
      end
    end
  end

  context "when the rows are built using nested slots" do
    subject! do
      render_inline(GovukComponent::TableComponent.new) do |table|
        table.with_head do |head|
          head.with_row do |row|
            helper.safe_join(1.upto(3).map { |i| row.with_cell(header: true, text: "header-col-#{i}") })
          end
        end

        table.with_body do |body|
          1.upto(3) do |i|
            body.with_row do |row|
              row.with_cell(text: "row-#{i}-col-1")
              row.with_cell(text: "row-#{i}-col-2")
              row.with_cell(text: "row-#{i}-col-3", scope: "bananas")
            end
          end
        end

        table.with_foot do |foot|
          foot.with_row do |row|
            helper.safe_join(1.upto(3).map { |i| row.with_cell(text: "foot-col-#{i}") })
          end
        end
      end
    end

    specify "renders a table" do
      expect(rendered_content).to have_tag('table', with: { class: "govuk-table" })
    end

    specify "the table has the right head content" do
      expect(rendered_content).to have_tag('table') do
        with_tag('thead') do
          with_tag('tr', with: { class: "govuk-table__row" }, count: 1) do
            with_tag('th', with: { class: "govuk-table__header", scope: "col" }, count: 3)
          end
        end
      end
    end

    specify "the table has the right body content" do
      expect(rendered_content).to have_tag('table') do
        with_tag('tbody') do
          with_tag('tr', count: 3)

          1.upto(3).map { |i| 1.upto(3).map { |j| "row-#{i}-col-#{j}" } }.each do |row|
            row.each { |value| with_tag('tr > td', text: value) }
          end
        end
      end
    end

    specify "the table has the right foot content" do
      expect(rendered_content).to have_tag('table') do
        with_tag('tfoot') do
          with_tag('tr', with: { class: "govuk-table__row" }, count: 1) do
            with_tag('td', with: { class: "govuk-table__footer" }, count: 3)
          end
        end
      end
    end

    specify "scopes can be set to arbitrary values" do
      expect(rendered_content).to have_tag("td", with: { scope: "bananas" }, count: 3)
    end
  end

  context 'when some data is numeric' do
    subject! do
      render_inline(GovukComponent::TableComponent.new) do |table|
        table.with_head do |head|
          head.with_row do |row|
            row.with_cell(text: "non-numeric", header: true)
            row.with_cell(text: "numeric", header: true, numeric: true)
          end
        end

        table.with_body do |body|
          1.upto(3) do |i|
            body.with_row do |row|
              row.with_cell(text: "non-numeric")
              row.with_cell(text: i, numeric: true)
            end
          end
        end
      end
    end

    specify "renders the numeric header with a numeric class" do
      expect(rendered_content).to have_tag("table > thead > tr > th", text: "numeric", with: { class: %w(govuk-table__header--numeric) })
    end

    specify "renders the numeric cells with a numeric classes" do
      1.upto(3).each do |i|
        expect(rendered_content).to have_tag("table > tbody > tr > td", text: i, with: { class: %w(govuk-table__cell--numeric) })
      end
    end
  end

  describe "captions" do
    specify "renders a caption with the correct text" do
      expect(rendered_content).to have_tag("table", with: { class: component_css_class }) do
        with_tag("caption", text: caption_text)
      end
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
                table.with_caption(text: "Caption size: #{size}", size:)
              end
            end

            specify "class '#{expected_class} is added" do
              expect(rendered_content).to have_tag('caption', with: { class: ["govuk-table__caption", "govuk-table__caption--#{size}"] })
            end
          end
        end
    end

    describe "when an invalid size is supplied" do
      let(:invalid_size) { 'xxxxxs' }
      let(:caption) { GovukComponent::TableComponent::CaptionComponent.new(text: "Bad size", size: invalid_size) }

      specify "fails with an appropriate error messsage" do
        expect { render_inline(caption) }.to raise_error(ArgumentError, /bad size #{invalid_size}/)
      end
    end

    describe "when the caption is provided in a block" do
      let(:fancy_caption_text) { "Fancy caption" }
      let(:fancy_caption) { helper.tag.span(fancy_caption_text) }

      subject do
        render_inline(GovukComponent::TableComponent.new(**kwargs)) do |table|
          table.with_caption { fancy_caption }
        end
      end

      specify "renders the custom caption content" do
        expect(rendered_content).to have_tag("caption > span", text: fancy_caption_text)
      end
    end

    describe "when no caption is provided" do
      subject do
        render_inline(GovukComponent::TableComponent.new(**kwargs)) do |table|
          table.with_head {}
          table.with_body {}
        end
      end

      specify "no caption tag is rendered" do
        expect(rendered_content).to have_tag("table") { without_tag("caption") }
      end
    end
  end

  describe "custom colum widths" do
    subject! do
      render_inline(GovukComponent::TableComponent.new) do |table|
        table.with_head do |head|
          head.with_row do |row|
            GovukComponent::TableComponent::CellComponent.widths.each_key do |width|
              row.with_cell(text: width, header: true, width:)
            end
          end
        end
      end
    end

    specify "adds the width class correctly" do
      GovukComponent::TableComponent::CellComponent.widths.each_key do |width, expected_class|
        expect(rendered_content).to have_tag("table > thead > tr > th", with: { class: expected_class }, text: width)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'

  describe "column groups and columns" do
    subject! do
      render_inline(GovukComponent::TableComponent.new) do |table|
        table.with_colgroup(classes: "first") do |colgroup|
          colgroup.with_col
          colgroup.with_col(span: 2)
          colgroup.with_col
        end

        table.with_colgroup(classes: "second") do |colgroup|
          colgroup.with_col
          colgroup.with_col(span: 3)
        end
      end
    end

    specify "renders colgroups with the correct attributes" do
      expect(rendered_content).to have_tag("table", with: { class: "govuk-table" }) do
        with_tag("colgroup", count: 2)
      end
    end

    specify "renders the correct columns" do
      expect(rendered_content).to have_tag("table", with: { class: "govuk-table" }) do
        with_tag("colgroup", with: { class: "first" }) do
          with_tag("col", count: 3)
          with_tag("col", with: { span: 2 }, count: 1)
        end

        with_tag("colgroup", with: { class: "second" }) do
          with_tag("col", count: 2)
          with_tag("col", with: { span: 3 }, count: 1)
        end
      end
    end
  end
end

RSpec.describe(GovukComponent::TableComponent::HeadComponent, type: :component) do
  let(:component_css_class) { 'govuk-table__head' }
  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(GovukComponent::TableComponent::BodyComponent, type: :component) do
  let(:component_css_class) { 'govuk-table__body' }
  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(GovukComponent::TableComponent::RowComponent, type: :component) do
  let(:component_css_class) { 'govuk-table__row' }
  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(GovukComponent::TableComponent::CellComponent, type: :component) do
  let(:component_css_class) { 'govuk-table__cell' }
  let(:kwargs) { { scope: nil } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  describe "controlling scopes" do
    subject! do
      render_inline(GovukComponent::TableComponent::RowComponent.new(parent: 'tbody')) do |row|
        row.with_cell(
          text: "ABC",
          scope: false,
          header: true,
          html_attributes: { class: "scope_is_false" },
        )
        row.with_cell(
          text: "DEF",
          scope: true,
          header: true,
          html_attributes: { class: "scope_is_true" },
        )
        row.with_cell(
          text: "GHI",
          scope: "custom",
          header: false,
          html_attributes: { class: "scope_on_td" },
        )
      end
    end

    it "suppresses the scope attribute when scope: false" do
      expect(html.at_css('th.scope_is_false').attributes.keys).to match_array(%w(class))
    end

    it "doesn't suppress the scope attribute when scope: true" do
      expect(html.at_css('th.scope_is_true').attributes.keys).to match_array(%w(class scope))
    end

    it "sets the custom scope when scope: 'custom'" do
      expect(rendered_content).to have_tag('td', with: { class: 'scope_on_td', scope: 'custom' })
    end
  end

  describe "rowspan and colspan" do
    subject! do
      render_inline(GovukComponent::TableComponent::RowComponent.new(parent: 'tbody')) do |row|
        row.with_cell(text: "span test", rowspan: 2, colspan: 3)
      end
    end

    it "sets the colspan and rowspan attributes correctly" do
      expect(rendered_content).to have_tag('td', with: { class: "govuk-table__cell", rowspan: "2", colspan: "3" })
    end
  end
end

RSpec.describe(GovukComponent::TableComponent::CaptionComponent, type: :component) do
  let(:component_css_class) { 'govuk-table__caption' }
  let(:kwargs) { { text: "Some caption" } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(GovukComponent::TableComponent::FootComponent, type: :component) do
  let(:component_css_class) { 'govuk-table__foot' }
  let(:kwargs) { { rows: [%w(a b c)] } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(GovukComponent::TableComponent::ColGroupComponent, type: :component) do
  let(:component_css_class) { nil }
  let(:component_tag) { 'colgroup' }
  let(:kwargs) { { cols: [1, 1] } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  describe "conditionally rendering based on column presence" do
    subject! do
      render_inline(GovukComponent::TableComponent::ColGroupComponent.new(**kwargs))
    end

    context "when there are cols" do
      specify "the col group is rendered" do
        expect(rendered_content).to have_tag("colgroup") { with_tag("col", count: 2) }
      end
    end

    context "when there are no cols" do
      let(:kwargs) { { cols: [] } }

      specify "nothing is rendered" do
        expect(rendered_content).to be_blank
      end
    end
  end
end

RSpec.describe(GovukComponent::TableComponent::ColGroupComponent::ColComponent, type: :component) do
  let(:component_css_class) { nil }
  let(:component_tag) { 'col' }
  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
