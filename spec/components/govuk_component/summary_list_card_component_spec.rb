require 'spec_helper'

RSpec.describe(GovukComponent::SummaryListComponent::CardComponent, type: :component) do
  let(:component_css_class) { 'govuk-summary-list' }
  let(:rows) do
    [
      # row 1
      {
        key: {
          text: "Name",
          html_attributes: { class: "row-1-custom-key-class", data: { id: "row-1-key-custom-data-id" } },
        },
        value: {
          text: "Sherlock Holmes",
          html_attributes: { class: "row-1-custom-value-key-class", data: { id: "row-1-value-custom-data-id" } },
        },
        actions: [
          {
            text: "Change",
            href: "/row-1-action-1-href",
            visually_hidden_text: "name",
            html_attributes: { class: "row-1-custom-action-1-class", data: { id: "row-1-action-1-data-id" } }
          },
        ],
        html_attributes: { class: "row-1-custom-class", data: { id: "row-1-custom-data-id" } },
      },

      # row 2
      {
        key: {
          text: "Address",
          html_attributes: { class: "row-2-custom-key-class", data: { id: "row-2-key-custom-data-id" } },
        },
        value: {
          text: "331 Baker Street, London",
          html_attributes: { class: "row-2-custom-value-class", data: { id: "row-2-key-custom-data-id" } },
        },
        actions: [
          {
            text: "Change",
            href: "/row-2-action-1-href",
            visually_hidden_text: "address",
            html_attributes: { class: "row-2-custom-action-1-class", data: { id: "row-2-action-1-data-id" } }
          },
          {
            text: "Delete",
            href: "/row-2-action-2-href",
            visually_hidden_text: "address",
            html_attributes: { class: "row-2-custom-action-2-class", data: { id: "row-2-action-2-data-id" } }
          }
        ],
        html_attributes: { class: "row-2-custom-class", data: { id: "row-2-custom-data-id" } },
      },
    ]
  end

  let(:title) { "Some title" }

  subject! do
    render_inline(described_class.new(title: title)) do |component|
      component.with_summary_list(rows: rows)
    end
  end

  specify "renders a card" do
    expect(rendered_content).to have_tag("div", with: { class: "govuk-summary-card" })
  end

  specify "the card has the right title" do
    expect(rendered_content).to have_tag("h2", text: title, with: { class: "govuk-summary-card__title" })
  end

  specify "card contains a summary list" do
    expect(rendered_content).to have_tag("dl", with: { class: "govuk-summary-list" })
  end

  specify "no actions list is rendered" do
    expect(rendered_content).not_to have_tag("ul", with: { class: "govuk-summary-card__actions" })
  end

  context "when there are actions" do
    let(:actions) { %w[abc def] }

    subject! do
      render_inline(described_class.new(title: title, actions: actions)) do |component|
        component.with_summary_list(rows: rows)
      end
    end

    specify "the actions are rendered" do
      expect(rendered_content).to have_tag("ul", with: { class: "govuk-summary-card__actions" }) do
        actions.each { |action| with_tag("li", text: action, with: { class: "govuk-summary-card__action" }) }
      end
    end
  end
end
