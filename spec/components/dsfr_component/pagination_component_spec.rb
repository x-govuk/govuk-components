require 'spec_helper'

RSpec.describe(DsfrComponent::PaginationComponent, type: :component) do
  let(:count) { 30 }
  let(:items) { 5 }
  let(:size) { [1, 2, 2, 1] }
  let(:defaults) { { count: count, items: items, size: size } }
  let(:current_page) { 2 }
  let(:pagy) { Pagy.new(page: current_page, **defaults) }
  let(:component_css_class) { 'govuk-pagination' }

  let(:kwargs) { { pagy: pagy } }

  subject! { render_inline(DsfrComponent::PaginationComponent.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  specify "renders some page items" do
    expect(rendered_content).to have_tag("nav", with: { class: component_css_class }) do
      with_tag("ul.govuk-pagination__list") do
        (1..5).to_a.all? do |i|
          with_tag("li.govuk-pagination__item", text: i)
        end
      end
    end
  end

  specify "is not in block mode" do
    expect(rendered_content).not_to have_tag("nav", with: { class: %w(govuk-pagination--block) })
  end

  specify "renders a default landmark label of 'results'" do
    expect(rendered_content).to have_tag("nav", with: { "aria-label" => "results" })
  end

  specify "renders a previous link" do
    expect(rendered_content).to have_tag("nav") do
      with_tag("div", with: { class: %w(govuk-pagination__prev) }) do
        with_tag("a", with: { class: %w(fr-link govuk-pagination__link) }, text: "Previous page")
        with_tag("svg", with: { class: %w(govuk-pagination__icon govuk-pagination__icon--prev) })
      end
    end
  end

  specify "renders a next link" do
    expect(rendered_content).to have_tag("nav") do
      with_tag("div", with: { class: %w(govuk-pagination__next) }) do
        with_tag("a", with: { class: %w(fr-link govuk-pagination__link) }, text: "Next page")
        with_tag("svg", with: { class: %w(govuk-pagination__icon govuk-pagination__icon--next) })
      end
    end
  end

  specify "current page has a special class" do
    expect(rendered_content).to have_tag("nav ul") do
      with_tag("li", with: { class: "govuk-pagination__item--current" }, count: 1) do
        with_tag("a", with: { class: "govuk-pagination__link" }, text: 2)
      end
    end
  end

  context "when the landmark_label is overridden" do
    let(:custom_landmark_label) { "Events" }
    let(:kwargs) { { pagy: pagy, landmark_label: custom_landmark_label } }

    specify "replaces the default landmark label with the custom one" do
      expect(rendered_content).to have_tag("nav", with: { "aria-label" => custom_landmark_label })
    end
  end

  context "when there a hundred pages" do
    # These are the suggested ellipses locations from the draft GOV.UK
    # pagination docs
    #
    # [1] 2 ⋯ 100
    # 1 [2] 3 ⋯ 100
    # 1 2 [3] 4 ⋯ 100
    # 1 2 3 [4] 5 ⋯ 100
    # 1 ⋯ 4 [5] 6 ⋯ 100
    # 1 ⋯ 97 [98] 99 100
    # 1 ⋯ 98 [99] 100
    # 1 ⋯ 99 [100]
    #
    # Pagy is configurable so we'll override set the defaults here:
    let(:count) { 500 }
    let(:size) { [1, 1, 1, 1] }
    let(:nav_element_text) { html.css("nav > div,ul > li").map(&:text) }
    let(:ellipsis) { "⋯" }

    # [1] 2 ⋯ 100
    context "we're on the first page" do
      let(:current_page) { 1 }

      specify "renders [1] 2 ⋯ 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("li", text: /1/)
          with_tag("a", text: /2/)
          with_tag("li", text: "⋯")
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["1", "2", ellipsis, "100", "Next page"])
      end
    end

    # 1 [2] 3 ⋯ 100
    context "we're on the second page" do
      let(:current_page) { 2 }

      specify "renders 1 [2] 3 ⋯ 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("li", text: /2/)
          with_tag("a", text: /3/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", "2", "3", ellipsis, "100", "Next page"])
      end
    end

    # 1 2 [3] 4 ⋯ 100
    context "we're on the third page" do
      let(:current_page) { 3 }

      specify "renders 1 2 [3] 4 ⋯ 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("a", text: /2/)
          with_tag("li", text: /3/)
          with_tag("a", text: /4/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", "2", "3", "4", ellipsis, "100", "Next page"])
      end
    end

    # 1 2 3 [4] 5 ⋯ 100
    context "we're on the fourth page" do
      let(:current_page) { 4 }

      specify "renders 1 2 3 [4] 5 ⋯ 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("a", text: /2/)
          with_tag("a", text: /3/)
          with_tag("li", text: /4/)
          with_tag("a", text: /5/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", "2", "3", "4", "5", ellipsis, "100", "Next page"])
      end
    end

    # 1 ⋯ 4 [5] 6 ⋯ 100
    context "we're on the fifth page" do
      let(:current_page) { 5 }

      specify "renders 1 ⋯ 4 [5] 6 ⋯ 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /4/)
          with_tag("li", text: /5/)
          with_tag("a", text: /6/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", ellipsis, "4", "5", "6", ellipsis, "100", "Next page"])
      end
    end
    # 1 ⋯ 97 [98] 99 100
    context "we're on the ninety-eigth page" do
      let(:current_page) { 98 }

      specify "renders 1 ⋯ 97 [98] 99 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /97/)
          with_tag("li", text: /98/)
          with_tag("a", text: /99/)
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", ellipsis, "97", "98", "99", "100", "Next page"])
      end
    end

    # 1 ⋯ 98 [99] 100
    context "we're on the ninety-ninth page (I feel bad for you son)" do
      let(:current_page) { 99 }

      specify "renders 1 ⋯ 98 [99] 100" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /98/)
          with_tag("li", text: /99/)
          with_tag("a", text: /100/)
          with_tag("div", text: /Next/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", ellipsis, "98", "99", "100", "Next page"])
      end
    end

    # 1 ⋯ 99 [100]
    context "we're on the one-hundredth page" do
      let(:current_page) { 100 }

      specify "renders 1 ⋯ 99 [100]" do
        expect(rendered_content).to have_tag("nav", with: { class: "govuk-pagination" }) do
          with_tag("div", text: /Previous/)
          with_tag("a", text: /1/)
          with_tag("li", text: ellipsis)
          with_tag("a", text: /99/)
          with_tag("li", text: /100/)
        end

        expect(nav_element_text).to eql(["Previous page", "1", ellipsis, "99", "100"])
      end
    end
  end

  context "when we're on the first page" do
    let(:current_page) { 1 }

    specify "renders no previous link" do
      expect(rendered_content).not_to have_tag("li", with: { class: "govuk-pagination__item--prev" })
    end
  end

  context "when we're on the last page" do
    let(:current_page) { 6 }

    specify "renders no next link" do
      expect(rendered_content).not_to have_tag("li", with: { class: "govuk-pagination__item--next" })
    end
  end

  context "when there are more pages than can be shown" do
    let(:count) { 90 }

    specify "renders ellipses" do
      expect(rendered_content).to have_tag("li", with: { class: %w(govuk-pagination__item govuk-pagination__item--ellipses) })
    end
  end

  context "link labels" do
    previous_page = OpenStruct.new(
      suffix: "prev",
      href: "/previous",
      text: "Backwards",
      label: "Let's go back to the page before"
    )

    next_page = OpenStruct.new(
      suffix: "next",
      href: "/next",
      text: "Forwards",
      label: "To the page beyond"
    )

    let(:previous_href) { previous_page.href }
    let(:previous_text) { previous_page.text }
    let(:previous_label) { previous_page.label }
    let(:next_href) { next_page.href }
    let(:next_text) { next_page.text }
    let(:next_label) { next_page.label }

    subject! do
      render_inline(DsfrComponent::PaginationComponent.new) do |pagination|
        pagination.previous_page(href: previous_href, text: previous_text, label_text: previous_label)
        pagination.next_page(href: next_href, text: next_text, label_text: next_label)
      end
    end

    specify "switches to block mode when there are no items" do
      expect(rendered_content).to have_tag("nav", with: { class: %w(govuk-pagination govuk-pagination--block) })
    end

    specify "renders link containers" do
      expect(rendered_content).to have_tag("nav") do
        with_tag("div", class: "govuk-pagination__prev")
        with_tag("div", class: "govuk-pagination__next")
      end
    end

    { "previous page" => previous_page, "next page" => next_page }.each do |description, page|
      describe description do
        let(:selector) { "nav .govuk-pagination__#{page.suffix}" }

        specify "has the correct title" do
          expect(rendered_content).to have_tag(selector) do
            with_tag("span", text: Regexp.new(page.text), with: { class: "govuk-pagination__link-title" })
          end
        end

        specify "has the correct label" do
          expect(rendered_content).to have_tag(selector) do
            with_tag("span", text: page.label, with: { class: "govuk-pagination__link-label" })
          end
        end

        specify "has an arrow" do
          expect(rendered_content).to have_tag(selector) do
            with_tag("svg", with: { class: ["govuk-pagination__icon", "govuk-pagination__icon--#{page.suffix}"] })
          end
        end

        specify "has a visually-hidden divider" do
          expect(rendered_content).to have_tag(selector) do
            with_tag("span", text: ":", with: { class: %w(govuk-visually-hidden) })
          end
        end
      end
    end

    context "when labels are omitted" do
      let(:expected_classes) { %w(govuk-pagination__link-title govuk-pagination__link-title--decorated) }

      subject! do
        render_inline(DsfrComponent::PaginationComponent.new) do |pagination|
          pagination.previous_page(href: previous_href, text: previous_text)
          pagination.next_page(href: next_href, text: next_text)
        end
      end

      specify "the previous title is decorated" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-pagination__prev" }) do
          with_tag("span", text: previous_page.text, with: { class: expected_classes })
        end
      end

      specify "the next title is decorated" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-pagination__next" }) do
          with_tag("span", text: next_page.text, with: { class: expected_classes })
        end
      end
    end
  end

  describe "manually passing in page items" do
    subject! do
      render_inline(DsfrComponent::PaginationComponent.new) do |pagination|
        pagination.previous_page(href: "#prev")
        pagination.item(href: "#1", number: 1)
        pagination.item(href: "#2", number: 2)
        pagination.item(href: "#3", number: 3, visually_hidden_text: "third")
        pagination.next_page(href: "#next")
      end
    end

    specify "renders a pagination block with the correct pages" do
      expect(rendered_content).to have_tag("nav") do
        with_tag("div", with: { class: "govuk-pagination__prev" })
        with_tag("li", text: "1")
        with_tag("li", text: "2")
        with_tag("li", text: "3")
        with_tag("div", with: { class: "govuk-pagination__next" })
      end
    end

    specify "sets the default aria-label to 'Page X'" do
      expect(rendered_content).to have_tag("nav") do
        with_tag("li", text: "1", with: { "aria-label" => "Page 1" })
        with_tag("li", text: "2", with: { "aria-label" => "Page 2" })
      end
    end

    specify "overrides default visually hidden text with visually_hidden_text" do
      expect(rendered_content).to have_tag("nav") do
        with_tag("li", text: "3", with: { "aria-label" => "third" })
      end
    end
  end

  describe "not rendering" do
    context "when the pagy object only has one page" do
      let(:current_page) { 1 }
      let(:count) { 1 }

      specify "nothing is rendered" do
        expect(rendered_content).to be_empty
      end
    end

    context "when there are no pages or next/prev links" do
      subject! do
        render_inline(DsfrComponent::PaginationComponent.new)
      end

      specify "when there is no pagy object and neither a next or previous page" do
        expect(rendered_content).to be_empty
      end
    end
  end

  describe "overriding the next and previous text when using Pagy" do
    context "when the next text is overridden" do
      let(:next_text) { "Proceed" }

      subject! { render_inline(DsfrComponent::PaginationComponent.new(next_text: next_text, pagy: pagy)) }

      specify "the text value should be set correctly" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-pagination__next" }, text: next_text)
      end
    end

    context "when the previous text is overridden" do
      let(:previous_text) { "Regress" }

      subject! { render_inline(DsfrComponent::PaginationComponent.new(previous_text: previous_text, pagy: pagy)) }

      specify "the text value should be set correctly" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-pagination__prev" }, text: previous_text)
      end
    end
  end
end

RSpec.describe(DsfrComponent::PaginationComponent::PreviousPage, type: :component) do
  let(:component_css_class) { 'govuk-pagination__prev' }

  let(:kwargs) { { href: "#", text: "1" } }

  subject! { render_inline(DsfrComponent::PaginationComponent::PreviousPage.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(DsfrComponent::PaginationComponent::NextPage, type: :component) do
  let(:component_css_class) { 'govuk-pagination__next' }

  let(:kwargs) { { href: "#", text: "1" } }

  subject! { render_inline(DsfrComponent::PaginationComponent::NextPage.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

RSpec.describe(DsfrComponent::PaginationComponent::Item, type: :component) do
  let(:component_css_class) { 'govuk-pagination__item' }

  let(:kwargs) { { href: "#", number: 2 } }

  subject! { render_inline(DsfrComponent::PaginationComponent::Item.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
