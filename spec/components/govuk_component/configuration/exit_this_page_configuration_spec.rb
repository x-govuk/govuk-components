require 'spec_helper'

RSpec.describe(GovukComponent::ExitThisPageComponent, type: :component) do
  describe 'configuration' do
    after { Govuk::Components.reset! }

    describe 'default_exit_this_page_text' do
      let(:overridden_text) { 'Leave now' }

      before do
        Govuk::Components.configure do |config|
          config.default_exit_this_page_text = overridden_text
        end
      end

      subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

      specify "renders the exit component with the custom text" do
        expect(rendered_content).to have_tag("a", text: overridden_text)
      end
    end

    describe 'default_exit_this_page_redirect_url' do
      let(:overridden_redirect_url) { 'https://www.github.com' }

      before do
        Govuk::Components.configure do |config|
          config.default_exit_this_page_redirect_url = overridden_redirect_url
        end
      end

      subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

      specify "renders the exit component with the custom redirect url" do
        expect(rendered_content).to have_tag("a", with: { href: overridden_redirect_url })
      end
    end
  end
end
