require 'spec_helper'

RSpec.describe(GovukComponent::HeaderComponent, type: :component) do
  let(:kwargs) { {} }

  describe 'configuration' do
    after { Govuk::Components.reset! }

    describe 'default_header_homepage_url' do
      let(:overriddden_homepage_url) { "/some-page" }

      before do
        Govuk::Components.configure do |config|
          config.default_header_homepage_url = overriddden_homepage_url
        end
      end

      specify "renders header with overridden homepage url" do
        render_inline(GovukComponent::HeaderComponent.new)

        expect(rendered_content).to have_tag("a", {
          with: { href: overriddden_homepage_url, class: "govuk-header__homepage-link" }
        })
      end
    end
  end
end
