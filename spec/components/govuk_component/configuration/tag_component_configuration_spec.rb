require 'spec_helper'

RSpec.describe(GovukComponent::TagComponent, type: :component) do
  let(:text) { 'Alert' }
  let(:kwargs) { { text: text } }
  let(:component_css_class) { 'govuk-tag' }

  let(:default_colour) { "green" }

  describe 'configuration' do
    after { Govuk::Components.reset! }

    describe 'colours' do
      before do
        Govuk::Components.configure do |config|
          config.default_tag_component_colour = default_colour
        end
      end

      subject! { render_inline(GovukComponent::TagComponent.new(**kwargs)) }

      specify "renders a tag with the overridden default colour" do
        expect(rendered_content).to have_tag("strong", with: { class: "govuk-tag--#{default_colour}" })
      end
    end
  end
end
