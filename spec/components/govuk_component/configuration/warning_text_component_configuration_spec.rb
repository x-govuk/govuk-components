require 'spec_helper'

RSpec.describe(GovukComponent::WarningTextComponent, type: :component) do
  describe 'configuration' do
    after { Govuk::Components.reset! }

    let(:kwargs) { { text: "Something important" } }

    describe 'default_warning_text_icon_fallback_text' do
      let(:overridden_fallback_text) { "Uh-oh" }

      before do
        Govuk::Components.configure do |config|
          config.default_warning_text_icon_fallback_text = overridden_fallback_text
        end
      end

      subject! { render_inline(GovukComponent::WarningTextComponent.new(**kwargs)) }

      specify "renders the warning text with overridden icon fallback text" do
        expect(rendered_content).to have_tag("span", text: overridden_fallback_text, with: { class: "govuk-visually-hidden" })
      end
    end

    describe 'default_warning_text_icon' do
      let(:overridden_icon) { "😲" }

      before do
        Govuk::Components.configure do |config|
          config.default_warning_text_icon = overridden_icon
        end
      end

      subject! { render_inline(GovukComponent::WarningTextComponent.new(**kwargs)) }

      specify "renders the warning text with overridden icon" do
        expect(rendered_content).to have_tag("span", text: overridden_icon, with: { class: "govuk-warning-text__icon" })
      end
    end
  end
end
