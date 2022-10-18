require 'spec_helper'

RSpec.describe(DsfrComponent::PaginationComponent, type: :component) do
  let(:pagy) { Pagy.new(page: 2, count: 20, items: 5, size: [1, 1, 1, 1]) }
  let(:kwargs) { { pagy: pagy } }

  describe "configuration" do
    after { Dsfr::Components.reset! }

    describe "default_pagination_landmark_label" do
      let(:overridden_landmark_label) { "Landmark label" }

      before do
        Dsfr::Components.configure do |config|
          config.default_pagination_landmark_label = overridden_landmark_label
        end
      end

      subject! { render_inline(DsfrComponent::PaginationComponent.new(**kwargs)) }

      specify "sets the nav's aria-label to the overridden value" do
        expect(rendered_content).to have_tag("nav", with: { "aria-label" => overridden_landmark_label })
      end
    end

    describe "default_pagination_next_text" do
      let(:next_text) { "Rightwards" }

      before do
        Dsfr::Components.configure do |config|
          config.default_pagination_next_text = next_text
        end
      end

      subject! { render_inline(DsfrComponent::PaginationComponent.new(**kwargs)) }

      specify "sets the 'next' text to the overridden value" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-pagination__next" }) do
          with_tag("span", with: { class: "govuk-pagination__link-title" }, text: next_text)
        end
      end
    end

    describe "default_pagination_previous_text" do
      let(:prev_text) { "Leftwards" }

      before do
        Dsfr::Components.configure do |config|
          config.default_pagination_previous_text = prev_text
        end
      end

      subject! { render_inline(DsfrComponent::PaginationComponent.new(**kwargs)) }

      specify "sets the 'previous' text to the overridden value" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-pagination__prev" }) do
          with_tag("span", with: { class: "govuk-pagination__link-title" }, text: prev_text)
          without_tag("span", with: { class: "govuk-visually-hidden" })
        end
      end
    end
  end
end
