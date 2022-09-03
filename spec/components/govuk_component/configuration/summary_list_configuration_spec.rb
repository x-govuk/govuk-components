require 'spec_helper'

RSpec.describe(GovukComponent::SummaryListComponent, type: :component) do
  describe 'configuration' do
    after { Govuk::Components.reset! }

    describe 'default_summary_list_borders' do
      before do
        Govuk::Components.configure do |config|
          config.default_summary_list_borders = false
        end
      end

      subject! { render_inline(GovukComponent::SummaryListComponent.new) }

      specify "renders the borders based on the config setting" do
        expect(rendered_content).to have_tag("dl", with: { class: "govuk-summary-list--no-border" })
      end
    end
  end
end
