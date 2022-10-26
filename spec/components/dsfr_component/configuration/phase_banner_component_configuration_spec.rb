require 'spec_helper'

RSpec.describe(DsfrComponent::PhaseBannerComponent, type: :component) do
  describe "configuration" do
    after { Dsfr::Components.reset! }

    describe 'default phase banner component tag and text' do
      let(:overridden_default_tag) { 'Beta' }
      let(:overridden_default_text) { 'Public service' }

      before do
        Dsfr::Components.configure do |config|
          config.default_phase_banner_tag = overridden_default_tag
          config.default_phase_banner_text = overridden_default_text
        end
      end

      subject! { render_inline(DsfrComponent::PhaseBannerComponent.new) }

      specify "renders div element with the overridden text and banner tag" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-phase-banner" }) do
          with_tag("p", with: { class: "govuk-phase-banner__content" }) do
            with_tag("strong", text: overridden_default_tag, with: { class: "govuk-phase-banner__content__tag" })
            with_tag("span", text: overridden_default_text, with: { class: "govuk-phase-banner__text" })
          end
        end
      end
    end
  end
end
