require 'spec_helper'

RSpec.describe(DsfrComponent::PhaseBannerComponent, type: :component) do
  let(:component_css_class) { "govuk-phase-banner" }

  let(:phase) { 'Gamma' }
  let(:text) { 'This is an experimental service – be cautious' }
  let(:kwargs) { { tag: { text: phase }, text: text } }

  subject! { render_inline(DsfrComponent::PhaseBannerComponent.new(**kwargs)) }

  specify "renders div element with the right text and banner tag" do
    expect(rendered_content).to have_tag("div", with: { class: "govuk-phase-banner" }) do
      with_tag("p", with: { class: "govuk-phase-banner__content" }) do
        with_tag("strong", text: phase, with: { class: "govuk-phase-banner__content__tag" })
        with_tag("span", text: text, with: { class: "govuk-phase-banner__text" })
      end
    end
  end

  context 'when content is supplied via a block' do
    let(:content) { 'Ignore everything' }

    subject! do
      render_inline(DsfrComponent::PhaseBannerComponent.new(**kwargs.except(:text))) { content }
    end

    specify "renders div element with the right text, banner tag and content" do
      expect(rendered_content).to have_tag("div", with: { class: "govuk-phase-banner" }) do
        with_tag("p", with: { class: "govuk-phase-banner__content" }) do
          with_tag("strong", text: phase, with: { class: "govuk-phase-banner__content__tag" })
          with_tag("span", text: content, with: { class: "govuk-phase-banner__text" })
        end
      end
    end
  end

  context "when a custom phase tag colour is provided" do
    let(:kwargs) { { tag: { text: phase, colour: 'orange' }, text: text } }

    specify "the phase tag has the right colour class" do
      expect(rendered_content).to have_tag("strong", with: { class: "govuk-tag--orange" }, text: phase)
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
