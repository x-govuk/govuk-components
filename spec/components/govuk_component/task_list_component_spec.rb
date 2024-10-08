require 'spec_helper'

RSpec.describe(GovukComponent::TaskListComponent, type: :component) do
  let(:component_css_class) { 'govuk-task-list' }
  let(:id_prefix) { nil }
  let(:kwargs) { { id_prefix: }.compact }
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
        let(:list_item_one_kwargs) { { title:, href: } }

        specify "a link is rendered with the correct attributes" do
          expect(rendered_content).to have_tag("li", with: { class: %(govuk-task-list__item govuk-task-list__item--with-link) }) do
            with_tag("a", with: { class: %w(govuk-link govuk-task-list__link), href: }, text: title)
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

      context "when items have an element that cannot start yet" do
        let(:list_item_two_kwargs) { { title: "Two", status: { text: "todo", cannot_start_yet: true } } }

        specify "the status has an extra class marking that it cannot yet be started" do
          expect(rendered_content).to have_tag(
            "div",
            with: { class: %w(govuk-task-list__status govuk-task-list__status--cannot-start-yet) },
            text: "todo",
          )
        end
      end

      context "when an item has an element that cannot start yet and a href" do
        let(:failing_component) do
          render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
            task_list.with_item(title: "Two", href: "#", status: { text: "todo", cannot_start_yet: true })
          end
        end

        specify "the component raises an error because an item has both a href and cannot_start_yet: true" do
          expect { failing_component }.to raise_error(ArgumentError, /item cannot have a href with status where cannot_start_yet: true/)
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

  describe "status cannot_start_yet" do
    let(:title_text) { "Choose a course" }
    let(:hint_text) { "Determine eligibility" }
    let(:status_text) { "Not done" }
    let(:cannot_start_yet) { false }
    let(:item_kwargs) { {} }

    subject! do
      render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
        task_list.with_item(**item_kwargs) do |item|
          helper.safe_join(
            [
              item.with_title(text: title_text, hint: hint_text),
              item.with_status(text: status_text, cannot_start_yet:),
            ]
          )
        end
      end
    end

    context "when false (default)" do
      specify "there is no govuk-task-list__status--cannot-start-yet class" do
        expect(rendered_content).not_to have_tag(".govuk-task-list__status--cannot-start-yet")
      end
    end

    context "when true" do
      let(:cannot_start_yet) { true }

      specify "the status has an extra class marking that it cannot yet be started" do
        expect(rendered_content).to have_tag(
          "div",
          with: { class: %w(govuk-task-list__status govuk-task-list__status--cannot-start-yet) },
          text: status_text,
        )
      end
    end

    context "when an item has an element that cannot start yet and a href" do
      let(:failing_component) do
        render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
          task_list.with_item(href: "https://www.gov.uk") do |item|
            helper.safe_join(
              [
                item.with_title(text: title_text, hint: hint_text),
                item.with_status(text: status_text, cannot_start_yet: true),
              ]
            )
          end
        end
      end

      specify "the component raises an error because an item has both a href and cannot_start_yet: true" do
        expect { failing_component }.to raise_error(ArgumentError, /item cannot have a href with status where cannot_start_yet: true/)
      end
    end
  end

  describe "status presence" do
    let(:status_class) { "govuk-task-list__status" }

    subject! do
      render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
        task_list.with_item(title: "Sample", status:)
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
    let(:href) { "/things" }
    let(:hint) { "Yes, things" }

    subject! do
      render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
        task_list.with_item(title: "A thing", href:, status: "Alright", hint:)
      end
    end

    context "when id_prefix is not present" do
      let(:expected_hint_id) { "task-list-1-hint" }
      let(:expected_status_id) { "task-list-1-status" }

      context "when a href is present" do
        specify("the hint has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_hint_id }) }
        specify("the status has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

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
        specify("the hint has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_hint_id }) }
        specify("the status has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

        specify "there is no aria-describeby attribute" do
          expect(rendered_content).not_to have_tag("*[aria-describedby]")
        end
      end

      context "when the status is present but the hint isn't" do
        let(:hint) { nil }
        specify("the hint is not rendered") { expect(rendered_content).not_to have_tag("div", with: { id: expected_hint_id }) }
        specify("the status has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

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
    end

    context "when id_prefix is present" do
      let(:expected_hint_id) { "#{id_prefix}-1-hint" }
      let(:expected_status_id) { "#{id_prefix}-1-status" }
      let(:id_prefix) { "abc" }

      context "when a href is present" do
        specify("the hint has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_hint_id }) }
        specify("the status has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

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
        specify("the hint has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_hint_id }) }
        specify("the status has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

        specify "there is no aria-describeby attribute" do
          expect(rendered_content).not_to have_tag("*[aria-describedby]")
        end
      end

      context "when the status is present but the hint isn't" do
        let(:hint) { nil }
        specify("the hint is not rendered") { expect(rendered_content).not_to have_tag("div", with: { id: expected_hint_id }) }
        specify("the status has an id starting with the id_prefix") { expect(rendered_content).to have_tag("div", with: { id: expected_status_id }) }

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
    end
  end

  describe "item numbering" do
    let(:items) { 4 }
    let(:list_item) { { title: "What a", hint: "very", status: "nice list" } }

    subject! do
      render_inline(GovukComponent::TaskListComponent.new(**kwargs)) do |task_list|
        items.times { task_list.with_item(**list_item) }
      end
    end

    specify "the items are sequentially numbered starting at 1" do
      actual_status_ids = html.css(".govuk-task-list__status").map { |element| element[:id] }
      actual_hint_ids = html.css(".govuk-task-list__hint").map { |element| element[:id] }

      expect(actual_status_ids).to eql(1.upto(items).map { |i| "task-list-#{i}-status" })
      expect(actual_hint_ids).to eql(1.upto(items).map { |i| "task-list-#{i}-hint" })
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'
end
