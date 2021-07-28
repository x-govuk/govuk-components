require 'spec_helper'

RSpec.describe(GovukComponent::SummaryListComponent, type: :component) do
  include_context 'helpers'
  include_context 'setup'

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
            row.action(href: "/action", text: "Action"),
          ]
        )
      end
    end
  end

  specify "renders the summary list with the key, value and action" do
    expect(rendered_component).to have_tag("dl", with: { class: component_css_class }) do
      with_tag("div", with: { class: "govuk-summary-list__row" }) do
        with_tag("dt", text: "Key", with: { class: "govuk-summary-list__key" })
        with_tag("dd", text: "Value", with: { class: "govuk-summary-list__value" })
        with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
          with_tag("a", with: { href: "/action" }, text: "Action")
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
              row.action(href: "/action-1", text: "First action"),
              row.action(href: "/action-2", text: "Second action"),
              row.action(href: "/action-3", text: "Third action"),
            ]
          )
        end
      end
    end

    specify "renders the summary list with the key, value and all the actions in an action list" do
      expect(rendered_component).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: "govuk-summary-list__row" }) do
          with_tag("dt", text: "Key")
          with_tag("dd", text: "Value")

          with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
            with_tag("ul", with: { class: "govuk-summary-list__actions-list" }) do
              { "/action-1" => "First action", "/action-2" => "Second action", "/action-3" => "Third action" }.each do |path, text|
                with_tag("li", with: { class: "govuk-summary-list__actions-list-item" }) do
                  with_tag("a", with: { href: path }, text: text)
                end
              end
            end
          end
        end
      end
    end
  end

  context "when some rows don't have actions" do
    subject! do
      render_inline(described_class.new(**kwargs)) do |component|
        component.row(classes: "with-actions") do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action")]
          )
        end

        component.row(classes: "without-actions") do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value")]
          )
        end
      end
    end

    specify "renders actions for the rows that do" do
      expect(rendered_component).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(with-actions govuk-summary-list__row) }) do
          with_tag("dd", with: { class: "govuk-summary-list__actions" })
        end
      end
    end

    specify "doesn't render actions on rows that don't" do
      expect(rendered_component).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(without-actions govuk-summary-list__row) }) do
          without_tag("dd", with: { class: "govuk-summary-list__actions" })
        end
      end
    end
  end

  context "when there is visually hidden text" do
    subject! do
      render_inline(described_class.new(**kwargs)) do |component|
        component.row(classes: "with-visually-hidden-text") do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action", visually_hidden_text: "visually hidden")]
          )
        end

        component.row(classes: "without-visually-hidden-text") do |row|
          helper.safe_join(
            [row.key(text: "Key"), row.value(text: "Value"), row.action(href: "/action", text: "Action")]
          )
        end
      end
    end

    specify "renders a span when visually hidden text is present" do
      expect(rendered_component).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(with-visually-hidden-text govuk-summary-list__row) }) do
          with_tag("dd", with: { class: "govuk-summary-list__actions" }) do
            with_tag("a.govuk-link > span", with: { class: "govuk-visually-hidden" })
          end
        end
      end
    end

    specify "renders no span when there's no visually hidden text" do
      expect(rendered_component).to have_tag("dl", with: { class: component_css_class }) do
        with_tag("div", with: { class: %(without-visually-hidden-text govuk-summary-list__row) }) do
          without_tag("span", with: { class: "govuk-visually-hidden" })
        end
      end
    end
  end
end
