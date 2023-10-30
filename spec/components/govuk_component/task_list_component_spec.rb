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

  describe "the outer list" do
    specify "renders a ul with the correct class" do
      expect(rendered_content).to have_tag("ul", with: { class: component_css_class })
    end
  end

  describe "the inner items" do
    context "when rendered with arguments" do
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
        let(:title) { "One" }
        let(:list_item_one_kwargs) { { title: title, href: href } }

        specify "a link is rendered with the correct attributes" do
          expect(rendered_content).to have_tag("li", with: { class: %(govuk-task-list__item govuk-task-list__item--with-link) }) do
            with_tag("a", with: { class: %w(govuk-link govuk-task-list__link), href: href }, text: title)
          end
        end
      end

      context "when no href is present" do
        let(:title) { "One" }
        let(:list_item_one_kwargs) { { title: "One" } }

        specify "a link is rendered with the correct attributes" do
          expect(rendered_content).to have_tag("li", with: { class: %(govuk-task-list__item) }, text: title)

          expect(rendered_content).not_to have_tag("a")
          expect(rendered_content).not_to have_tag("li", with: { class: "govuk-task-list__item--with-link" })
        end
      end

      context "when a hint present" do
        let(:hint_two) { "Two comes after one" }
        let(:list_item_two_kwargs) { { title: "Two", hint: hint_two } }

        specify "a hint is rendered with the correct attributes" do
          expect(rendered_content).to have_tag("li") do
            with_tag("div", text: hint_two, with: { class: "govuk-task-list__hint" })
          end
        end
      end

      context "when no hint is present" do
        let(:title) { "Three" }
        let(:list_item_two_kwargs) { { title: "Three" } }

        specify "a hint is rendered with the correct attributes" do
          expect(rendered_content).to have_tag("li", text: title)

          expect(rendered_content).not_to have_tag("div", with: { class: "govuk-task-list__hint" })
        end
      end

      context "when a tag is present in the status" do
        let(:status_text) { "Everything's OK" }
        let(:list_item_two_kwargs) { { title: "Two", status: helper.govuk_tag(text: "ok") } }

        specify "a status tag is rendered with the correct attributes and text" do
          expect(rendered_content).to have_tag("li") do
            with_tag("div", with: { class: %w(govuk-task-list__status) }) do
              with_tag("strong", with: { class: %w(govuk-tag) })
            end
          end
        end
      end
    end

    describe "when rendered with blocks" do
      let(:title_text) { "Select a book" }
      let(:hint_text) { "You will need the ISBN" }
      let(:status_text) { "Not done" }

      subject! do
        render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
          task_list.with_item do |item|
            helper.safe_join(
              [
                item.with_title(text: title_text, hint: hint_text),
                item.with_status(text: status_text),
              ]
            )
          end
        end
      end

      specify "the title and hint are rendered" do
        expect(rendered_content).to have_tag("li") do
          with_tag('div', with: { class: 'govuk-task-list__name-and-hint' }, text: Regexp.new(title_text)) do
            with_tag('div', with: { class: 'govuk-task-list__hint' }, text: hint_text)
          end
        end
      end

      specify "the status text is rendered" do
        expect(rendered_content).to have_tag("li") do
          with_tag('div', with: { class: 'govuk-task-list__status' }) do
            with_text(status_text)
          end
        end
      end
    end
  end

  describe "status presence" do
    let(:status_class) { "govuk-task-list__status" }

    subject! do
      render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
        task_list.with_item(title: "Sample", status: status)
      end
    end

    context "when status text is present" do
      let(:status) { "Some status" }

      specify "a status div is rendered" do
        expect(rendered_content).to have_tag("div", with: { class: status_class })
      end
    end

    context "when status text is blank" do
      let(:status) { "" }

      specify "no status div is rendered" do
        expect(rendered_content).not_to have_tag("div", with: { class: status_class })
      end
    end

    context "when status text is nil" do
      let(:status) { "" }

      specify "no status div is rendered" do
        expect(rendered_content).not_to have_tag("div", with: { class: status_class })
      end
    end
  end

  describe "ids and aria-describedby" do
    let(:identifier) { "abc" }
    let(:href) { "/things" }
    let(:hint) { "Yes, things" }
    let(:expected_hint_id) { "#{identifier}-hint" }
    let(:expected_status_id) { "#{identifier}-status" }

    subject! do
      render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
        task_list.with_item(identifier: identifier, title: "A thing", href: href, status: "Alright", hint: hint)
      end
    end

    context "when a href is present" do
      specify("the hint has an id ending with the identifier") { expect(rendered_content).to have_tag("div", with: { id: expected_hint_id }) }
      specify("the status has an id ending with the identifier") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

      specify "the title link is aria-describedby the hint and status ids" do
        expect(rendered_content).to have_tag(
          "a",
          with: {
            class: "govuk-link govuk-task-list__link",
            "aria-describedby" => %(#{expected_status_id} #{expected_hint_id}),
          }
        )
      end
    end

    context "when a href isn't present" do
      let(:href) { nil }
      specify("the hint has an id ending with the identifier") { expect(rendered_content).to have_tag("div", with: { id: expected_hint_id }) }
      specify("the status has an id ending with the identifier") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

      specify "there is no aria-describeby attribute" do
        expect(rendered_content).not_to have_tag("*[aria-describedby]")
      end
    end

    context "when the status is present but the hint isn't" do
      let(:hint) { nil }
      specify("the hint is not rendered") { expect(rendered_content).not_to have_tag("div", with: { id: expected_hint_id }) }
      specify("the status has an id ending with the identifier") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

      specify "the title is aria-describedby only the status id" do
        expect(rendered_content).to have_tag(
          "a",
          with: {
            class: "govuk-link govuk-task-list__link",
            "aria-describedby" => expected_status_id,
          }
        )
      end
    end

    # TODO: what should happen when there's no status. Components can't see
    #       their siblings so we don't really know whether or not there's a
    #       status to reference
    #
    #       assume it's there for now
    #
    # context "when the hint is present but the status isn't" do
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
