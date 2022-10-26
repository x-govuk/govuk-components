require "spec_helper"

RSpec.describe(DsfrComponent::CookieBannerComponent, type: :component) do
  let(:component_css_class) { 'govuk-cookie-banner' }

  describe "configuration" do
    after { Dsfr::Components.reset! }

    describe "default_cookie_banner_aria_label" do
      let(:overriden_aria_label) { "Biscuit flag" }

      before do
        Dsfr::Components.configure do |config|
          config.default_cookie_banner_aria_label = overriden_aria_label
        end
      end

      subject! do
        render_inline(described_class.new)
      end

      specify "renders a cookie banner div with the overriden aria label" do
        expected_attributes = {
          class: component_css_class,
          "aria-label" => overriden_aria_label,
        }

        expect(rendered_content).to have_tag("div", with: expected_attributes)
      end
    end

    describe "default_cookie_banner_hide_in_print" do
      let(:overriden_hide_in_print) { false }

      before do
        Dsfr::Components.configure do |config|
          config.default_cookie_banner_hide_in_print = overriden_hide_in_print
        end
      end

      subject! do
        render_inline(described_class.new)
      end

      specify "renders a cookie banner div with the correct class" do
        expect(rendered_content).to have_tag(
          "div",
          with: { class: component_css_class },
          without: { class: "govuk-\\!-display-none-print" }
        )
      end
    end
  end
end
