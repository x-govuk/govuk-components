require 'spec_helper'

RSpec.describe(DsfrComponent::FooterComponent, type: :component) do
  let(:selector) { "footer.govuk-footer .govuk-width-container .govuk-footer__meta" }
  let(:kwargs) { {} }

  describe 'configuration' do
    after { Dsfr::Components.reset! }

    describe 'default footer component text and url' do
      let(:overridden_default_text) { '© Not copyrighted' }
      let(:overridden_default_url) { 'www.gov.uk' }

      before do
        Dsfr::Components.configure do |config|
          config.default_footer_copyright_text = overridden_default_text
          config.default_footer_copyright_url = overridden_default_url
        end
      end

      subject! { render_inline(DsfrComponent::FooterComponent.new(**kwargs)) }

      specify 'renders the component with overriden default text and url' do
        expect(rendered_content).to have_tag(selector) do
          with_tag("div", with: { class: "govuk-footer__meta-item" }, text: overridden_default_text)
          with_tag("a", text: overridden_default_text, with: { href: overridden_default_url })
        end
      end
    end

    describe 'default_footer_meta_text' do
      let(:overridden_default_text) { 'some meta text' }

      before do
        Dsfr::Components.configure do |config|
          config.default_footer_meta_text = overridden_default_text
        end
      end

      subject! { render_inline(DsfrComponent::FooterComponent.new(meta_text: overridden_default_text)) }

      specify "custom text is rendered" do
        expect(rendered_content).to have_tag(
          "div",
          with: { class: "govuk-footer__meta-custom" },
          text: Regexp.new(overridden_default_text)
        )
      end
    end
  end
end
