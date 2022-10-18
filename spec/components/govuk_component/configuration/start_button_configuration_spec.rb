require 'spec_helper'

RSpec.describe(DsfrComponent::StartButtonComponent, type: :component) do
  describe 'configuration' do
    before do
      allow_any_instance_of(DsfrComponent::StartButtonComponent)
        .to(receive(:protect_against_forgery?).and_return(false))
    end

    after { Dsfr::Components.reset! }

    describe 'default_start_button_as_button' do
      let(:overridden_start_button) { true }

      let(:kwargs) { { text: "Begin", href: "https://example.com/begin" } }

      before do
        Dsfr::Components.configure do |config|
          config.default_start_button_as_button = overridden_start_button
        end
      end

      subject! { render_inline(DsfrComponent::StartButtonComponent.new(**kwargs)) }

      specify "renders the start button with the overridden button setting" do
        expect(rendered_content).to have_tag("button", with: { class: "fr-btn--start" })
      end
    end
  end
end
