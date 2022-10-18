require 'spec_helper'

RSpec.describe(DsfrComponent::SectionBreakComponent, type: :component) do
  describe 'configuration' do
    after { Dsfr::Components.reset! }

    describe 'default_section_break_visible' do
      let(:overridden_visibility) { true }

      before do
        Dsfr::Components.configure do |config|
          config.default_section_break_visible = overridden_visibility
        end
      end

      subject! { render_inline(DsfrComponent::SectionBreakComponent.new) }

      specify "renders the component with the overridden visibility" do
        expect(rendered_content).to have_tag("hr", with: { class: "govuk-section-break--visible" })
      end
    end

    describe 'default_section_break_size' do
      let(:overridden_size) { 'xl' }

      before do
        Dsfr::Components.configure do |config|
          config.default_section_break_size = overridden_size
        end
      end

      subject! { render_inline(DsfrComponent::SectionBreakComponent.new) }

      specify "renders the component with the overridden size" do
        expect(rendered_content).to have_tag("hr", with: { class: "govuk-section-break--#{overridden_size}" })
      end
    end
  end
end
