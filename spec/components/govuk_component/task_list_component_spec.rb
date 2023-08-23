require 'spec_helper'

RSpec.describe(GovukComponent::TaskListComponent, type: :component) do
  let(:component_css_class) { 'govuk-task-list' }
  let(:kwargs) { {} }
  let(:list_item_one_kwargs) { { title: "One", status: "in progress" } }
  let(:list_item_two_kwargs) { { title: "Two", status: "ok" } }

  subject! do
    render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
      task_list.with_item(**list_item_one_kwargs)
      task_list.with_item(**list_item_two_kwargs)
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  describe "rendering items with arguments" do
    specify "renders a list with the correct class and contents" do
      expect(rendered_content).to have_tag("ul", with: { class: component_css_class }) do
        with_tag("li", text: "One", with: { class: "govuk-task-list__item" }) do
          with_tag("div", with: { class: "govuk-task-list__status" }, text: "in progress")
        end

        with_tag("li", text: "Two", with: { class: "govuk-task-list__item" }) do
          with_tag("div", with: { class: "govuk-task-list__status" }, text: "ok")
        end
      end
    end

    context "when href is present" do
      let(:href) { "/item-one" }
      let(:list_item_one_kwargs) { { title: "One", status: "in progress", href: href } }

      specify "a link is rendered with the correct attributes" do
        expect(rendered_content).to have_tag("li") do
          with_tag("a", with: { href: href, class: %w(govuk-link govuk-task-list__link) })
        end
      end
    end

    context "when a hint present" do
      let(:hint_two) { "Two comes after one" }
      let(:list_item_two_kwargs) { { title: "Two", status: "ok", hint: hint_two } }

      specify "a hint is rendered with the correct attributes" do
        expect(rendered_content).to have_tag("li") do
          with_tag("div", text: hint_two, with: { class: "govuk-task-list__task_hint" })
        end
      end
    end

    context "when a status tag is present" do
      let(:status_text) { "Everything's OK" }
      let(:list_item_two_kwargs) { { title: "Two", status: "ok" } }

      specify "a status tag is rendered with the correct attributes and text" do
        expect(rendered_content).to have_tag("li") do
          with_tag("div", with: { class: %w(govuk-task-list__status) }) do
            with_tag("strong", with: { class: %w(govuk-tag) })
          end
        end
      end
    end
  end

  describe "rendering an entire task list with data" do
  end

  describe "rendering an entire task list with blocks" do
  end
end
