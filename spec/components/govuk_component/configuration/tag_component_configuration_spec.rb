require 'spec_helper'

RSpec.describe(DsfrComponent::TagComponent, type: :component) do
  let(:text) { 'Alert' }
  let(:kwargs) { { text: text } }
  let(:component_css_class) { 'govuk-tag' }

  let(:default_colour) { "green" }

  describe 'configuration' do
    after { Dsfr::Components.reset! }

    describe 'colours' do
      before do
        Dsfr::Components.configure do |config|
          config.default_tag_colour = default_colour
        end
      end

      subject! { render_inline(DsfrComponent::TagComponent.new(**kwargs)) }

      specify "renders a tag with the overridden default colour" do
        expect(rendered_content).to have_tag("strong", with: { class: "govuk-tag--#{default_colour}" })
      end
    end
  end
end
