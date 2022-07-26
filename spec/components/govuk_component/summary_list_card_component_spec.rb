require 'spec_helper'

RSpec.describe(GovukComponent::SummaryListComponent::CardComponent, type: :component) do
  let(:component_css_class) { 'govuk-summary-list' }
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

  subject! do
    render_inline(described_class.new(title: "Some title")) do |component|
      component.summary_list(rows: rows)
    end
  end

  specify "renders a card" do
    expect(rendered_content).to have_tag("div", with: { class: "govuk-summary-list__card" })
  end

  specify "card contains a summary list" do
    expect(rendered_content).to have_tag("dl", with: { class: "govuk-summary-list" })
  end
end
