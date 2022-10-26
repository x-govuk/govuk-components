require 'spec_helper'

RSpec.describe(DsfrComponent::SummaryListComponent, type: :component) do
  let(:component_css_class) { 'govuk-summary-list' }

  let(:action_link_text) { 'Something' }
  let(:action_link_href) { '#anchor' }

  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  subject! do
    render_inline(described_class.new(**kwargs)) do |component|
      component.row do |row|
        helper.safe_join(
          [
            row.key(text: "Key"),
            row.value(text: "Value"),
            row.action(href: "/action", text: "Action", visually_hidden_text: "for key"),
          ]
        )
      end
    end
  end

  specify "renders the summary list with the key, value and action" do
    expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
      with_tag("div", with: { class: "govuk-summary-list__row" }) do
        with_tag("dt", text: "Key", with: { class: "govuk-summary-list__key" })
        with_tag("dd", text: "Value", with: { class: "govuk-summary-list__value" })
        with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
          with_tag("a", with: { href: "/action" }, text: "Action for key")
        end
      end
    end
  end

  context "when there are multiple actions" do
    subject! do
      render_inline(described_class.new(**kwargs)) do |component|
        component.row do |row|
          helper.safe_join(
            [
              row.key(text: "Key"),
              row.value(text: "Value"),
              row.action(href: "/action-1", text: "First action", visually_hidden_text: "for key"),
              row.action(href: "/action-2", text: "Second action", visually_hidden_text: "for key"),
              row.action(href: "/action-3", text: "Third action", visually_hidden_text: "for key"),
            ]
          )
        end
      end
    end

    specify "renders the summary list with the key, value and all the actions in an action list" do
      expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: "govuk-summary-list__row" }) do
          with_tag("dt", text: "Key")
          with_tag("dd", text: "Value")

          with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
            with_tag("ul", with: { class: "govuk-summary-list__actions-list" }) do
              { "/action-1" => "First action", "/action-2" => "Second action", "/action-3" => "Third action" }.each do |path, text|
                with_tag("li", with: { class: "govuk-summary-list__actions-list-item" }) do
                  with_tag("a", with: { href: path }, text: text + " for key")
                end
              end
            end
          end
        end
      end
    end
  end

  context "when rows have actions" do
    subject! do
      render_inline(described_class.new(**kwargs)) do |component|
        component.row do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action", visually_hidden_text: "key")]
          )
        end
      end
    end

    specify "renders an actions column" do
      expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(govuk-summary-list__row) }) do
          with_tag("dd", with: { class: "govuk-summary-list__actions" })
        end
      end
    end
  end

  context "when no action is specified" do
    subject! do
      render_inline(described_class.new(**kwargs)) do |component|
        component.row do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value")]
          )
        end
      end
    end

    specify "doesn't render an action column" do
      expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(govuk-summary-list__row) }) do
          without_tag("dd", with: { class: "govuk-summary-list__actions" })
        end
      end
    end
  end

  context "when one row has actions and one does not" do
    subject! do
      render_inline(described_class.new(**kwargs)) do |component|
        component.row do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value"), row.action(href: nil, visually_hidden_text: nil)]
          )
        end

        component.row do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value")]
          )
        end
      end
    end

    specify "renders one row with the govuk-summary-list__row--no-actions class and no actions" do
      expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(govuk-summary-list__row govuk-summary-list__row--no-actions) }, count: 1) do
          without_tag("dd", with: { class: "govuk-summary-list__actions" })
        end
      end
    end

    specify "renders one row with actions" do
      expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(govuk-summary-list__row) }) do
          with_tag("dd", with: { class: "govuk-summary-list__actions" }, count: 1)
        end
      end
    end
  end

  context "when 'actions: false'" do
    subject! do
      render_inline(described_class.new(actions: false, **kwargs)) do |component|
        component.row { |row| helper.safe_join([row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/a", visually_hidden_text: "for key")]) }
        component.row { |row| helper.safe_join([row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/b", visually_hidden_text: "for key")]) }
        component.row { |row| helper.safe_join([row.key(text: "Key"), row.value(text: "Value")]) }
      end
    end

    specify "no actions are rendered, even when they're called on the row" do
      expect(rendered_content).not_to have_tag("dd", with: { class: "govuk-summary-list__actions" })
    end

    specify "no rows have the class 'govuk-summary-list__row--no-actions'" do
      expect(rendered_content).not_to have_tag("div", with: { class: %(govuk-summary-list__row govuk-summary-list__row--no-actions) })
    end
  end

  describe "visually hidden text" do
    context "when there is visually hidden text" do
      subject! do
        render_inline(described_class.new(**kwargs)) do |component|
          component.row do |row|
            helper.safe_join(
              [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action", visually_hidden_text: "visually hidden")]
            )
          end
        end
      end

      specify "renders a span containing visually hidden text separated by a space from the action text" do
        expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
          with_tag("div", with: { class: %(govuk-summary-list__row) }) do
            with_tag("dd", with: { class: "govuk-summary-list__actions" }, text: /Action\s/) do
              with_tag("a.fr-link > span", with: { class: "govuk-visually-hidden" })
            end
          end
        end
      end
    end

    context "when visually hidden text is nil" do
      subject! do
        render_inline(described_class.new(**kwargs)) do |component|
          component.row do |row|
            helper.safe_join(
              [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action", visually_hidden_text: nil)]
            )
          end
        end
      end

      specify "renders no span when there's no visually hidden text" do
        expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
          with_tag("div", with: { class: %(govuk-summary-list__row) }) do
            without_tag("span", with: { class: "govuk-visually-hidden" })
          end
        end
      end
    end

    context "when visually hidden text param is omitted" do
      subject! do
        render_inline(described_class.new(**kwargs)) do |component|
          component.row do |row|
            helper.safe_join(
              [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action")]
            )
          end
        end
      end

      specify "renders no span when there's no visually hidden text" do
        expect(rendered_content).to have_tag("dl", with: { class: component_css_class }) do
          with_tag("div", with: { class: %(govuk-summary-list__row) }) do
            without_tag("span", with: { class: "govuk-visually-hidden" })
          end
        end
      end
    end
  end

  describe "passing data directly into the summary list component" do
    subject! { render_inline(described_class.new(rows: rows)) }

    describe "setting keys, values and actions" do
      let(:rows) do
        [
          # row 1
          {
            key: {
              text: "Name",
              classes: "row-1-custom-key-class",
              html_attributes: { data: { id: "row-1-key-custom-data-id" } },
            },
            value: {
              text: "Sherlock Holmes",
              classes: "row-1-custom-value-key-class",
              html_attributes: { data: { id: "row-1-value-custom-data-id" } },
            },
            actions: [
              {
                text: "Change",
                href: "/row-1-action-1-href",
                visually_hidden_text: "name",
                classes: "row-1-custom-action-1-class",
                html_attributes: { data: { id: "row-1-action-1-data-id" } }
              },
            ],
            classes: "row-1-custom-class",
            html_attributes: { data: { id: "row-1-custom-data-id" } },
          },

          # row 2
          {
            key: {
              text: "Address",
              classes: "row-2-custom-key-class",
              html_attributes: { data: { id: "row-2-key-custom-data-id" } },
            },
            value: {
              text: "331 Baker Street, London",
              classes: "row-2-custom-value-class",
              html_attributes: { data: { id: "row-2-key-custom-data-id" } },
            },
            actions: [
              {
                text: "Change",
                href: "/row-2-action-1-href",
                visually_hidden_text: "address",
                classes: "row-2-custom-action-1-class",
                html_attributes: { data: { id: "row-2-action-1-data-id" } }
              },
              {
                text: "Delete",
                href: "/row-2-action-2-href",
                visually_hidden_text: "address",
                classes: "row-2-custom-action-2-class",
                html_attributes: { data: { id: "row-2-action-2-data-id" } }
              }
            ],
            classes: "row-2-custom-class",
            html_attributes: { data: { id: "row-2-custom-data-id" } },
          },
        ]
      end

      specify "renders a summary list with the right number of rows" do
        expect(rendered_content).to have_tag("dl", with: { class: "govuk-summary-list" }) do
          with_tag(".govuk-summary-list__row", count: 2)
        end
      end

      specify "renders rows with the custom classes" do
        %w(row-1-custom-class row-2-custom-class).each do |custom_class|
          expect(rendered_content).to have_tag("dl") do
            with_tag("div", with: { class: custom_class })
          end
        end
      end

      specify "renders rows with the custom HTML attributes" do
        %w(row-1-custom-data-id row-2-custom-data-id).each do |custom_data_id|
          expect(rendered_content).to have_tag("dl") do
            with_tag("div", with: { "data-id" => custom_data_id })
          end
        end
      end

      specify "renders keys with the right text, classes and HTML attributes" do
        expect(rendered_content).to have_tag("dl") do
          with_tag("div", with: { class: "row-1-custom-class" }) do
            with_tag("dt", {
              text: "Name",
              with: { class: "row-1-custom-key-class", "data-id" => "row-1-key-custom-data-id" }
            })
          end

          with_tag("div", with: { class: "row-2-custom-class" }) do
            with_tag("dt", {
              text: "Address",
              with: { class: "row-2-custom-key-class", "data-id" => "row-2-key-custom-data-id" }
            })
          end
        end
      end

      specify "renders single actions in the dd element" do
        expect(rendered_content).to have_tag("dl > .row-1-custom-class") do
          with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
            with_tag("a", {
              class: "fr-link",
              with: {
                href: "/row-1-action-1-href",
                class: "row-1-custom-action-1-class",
                "data-id" => "row-1-action-1-data-id"
              },
              text: /Change/
            }) do
              with_tag("span", with: { class: "govuk-visually-hidden" }, text: "name")
            end
          end
        end
      end

      specify "renders multiple actions in an actions list" do
        expect(rendered_content).to have_tag("dl > .row-2-custom-class") do
          with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
            with_tag("ul", with: { class: "govuk-summary-list__actions-list" }) do
              with_tag("a", {
                class: "fr-link",
                with: {
                  href: "/row-2-action-1-href",
                  class: "row-2-custom-action-1-class",
                  "data-id" => "row-2-action-1-data-id"
                },
                text: /Change/
              }) { with_tag("span", with: { class: "govuk-visually-hidden" }, text: "address") }

              with_tag("a", {
                class: "fr-link",
                with: {
                  href: "/row-2-action-2-href",
                  class: "row-2-custom-action-2-class",
                  "data-id" => "row-2-action-2-data-id"
                },
                text: /Delete/
              }) { with_tag("span", with: { class: "govuk-visually-hidden" }, text: "address") }
            end
          end
        end
      end
    end

    describe "applying the govuk-summary-list__row--no-actions class when some some rows don't have them" do
      let(:row_with_no_action) { { key: { text: "no-action" }, value: { text: "no-action" } } }
      let(:row_with_one_action) { { key: { text: "no-action" }, value: { text: "no-action" }, actions: [{ href: "/path", visually_hidden_text: "key" }] } }

      context "when no rows have actions" do
        let(:rows) { [row_with_no_action, row_with_no_action] }

        specify "no rows should have the govuk-summary-list__row--no-actions class" do
          expect(rendered_content).not_to have_tag("div", with: { class: "govuk-summary-list__row--no-actions" })
        end
      end

      context "when all rows have actions" do
        let(:rows) { [row_with_one_action, row_with_one_action] }

        specify "no rows should have the govuk-summary-list__row--no-actions class" do
          expect(rendered_content).not_to have_tag("div", with: { class: "govuk-summary-list__row--no-actions" })
        end
      end

      context "when some rows have actions and some don't" do
        let(:rows) { [row_with_one_action, row_with_no_action] }

        specify "one row has the govuk-summary-list__row--no-actions class" do
          expect(rendered_content).to have_tag("div", with: { class: "govuk-summary-list__row--no-actions" }, count: 1)
        end
      end
    end
  end
end

RSpec.describe(DsfrComponent::SummaryListComponent::RowComponent, type: :component) do
  let(:component_css_class) { 'govuk-summary-list__row' }
  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(DsfrComponent::SummaryListComponent::KeyComponent, type: :component) do
  let(:component_css_class) { 'govuk-summary-list__key' }
  let(:kwargs) { { text: "Some key" } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context "when there is no text or block" do
    specify "raises an appropriate error" do
      expect { render_inline(described_class.new) }.to raise_error(ArgumentError, "no text or content")
    end
  end

  context "when there is a block of HTML" do
    let(:custom_tag) { "h2" }
    let(:custom_text) { "Fancy heading" }

    subject! do
      render_inline(described_class.new) do
        helper.content_tag(custom_tag, custom_text)
      end
    end

    specify "the custom HTML is rendered" do
      expect(rendered_content).to have_tag("dt", with: { class: component_css_class }) do
        with_tag(custom_tag, text: custom_text)
      end
    end
  end
end

RSpec.describe(DsfrComponent::SummaryListComponent::ValueComponent, type: :component) do
  let(:component_css_class) { 'govuk-summary-list__value' }
  let(:kwargs) { { text: "Some value" } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context "when there is no text or block" do
    subject! { render_inline(described_class.new) }

    specify "renders an empty dd element" do
      expect(rendered_content).to have_tag("dd", with: { class: "govuk-summary-list__value" }, text: "")
    end
  end

  context "when there is a block of HTML" do
    let(:custom_tag) { "h3" }
    let(:custom_text) { "Fancier heading" }

    subject! do
      render_inline(described_class.new) do
        helper.content_tag(custom_tag, custom_text)
      end
    end

    specify "the custom HTML is rendered" do
      expect(rendered_content).to have_tag("dd", with: { class: component_css_class }) do
        with_tag(custom_tag, text: custom_text)
      end
    end
  end
end

RSpec.describe(DsfrComponent::SummaryListComponent::ActionComponent, type: :component) do
  let(:custom_path) { "/some/endpoint" }
  let(:component_css_class) { 'fr-link' }
  let(:kwargs) { { href: custom_path, text: "Some value", visually_hidden_text: nil } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context "when there is no text" do
    subject! do
      render_inline(described_class.new(href: custom_path, visually_hidden_text: nil))
    end

    specify "the text defaults to 'Change'" do
      expect(rendered_content).to have_tag("a", with: { class: "fr-link" }, text: "Change")
    end
  end

  context "when text is nil and there's no block" do
    specify "raises an appropriate error" do
      expect { render_inline(described_class.new(**kwargs.merge(text: nil, visually_hidden_text: nil))) }.to raise_error(ArgumentError, "no text or content")
    end
  end

  context "when there is a block of HTML" do
    let(:custom_tag) { "span" }
    let(:custom_text) { "Do a thing, now" }

    subject! do
      render_inline(described_class.new(href: custom_path, visually_hidden_text: nil)) do
        helper.content_tag(custom_tag, custom_text)
      end
    end

    specify "the custom HTML is rendered" do
      expect(rendered_content).to have_tag("a", with: { class: component_css_class }) do
        with_tag(custom_tag, text: custom_text)
      end
    end
  end
end
