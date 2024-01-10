require 'spec_helper'

RSpec.describe(GovukComponent::TableComponent::CellComponent, type: :component) do
  let(:text) { 'Content' }
  let(:kwargs) { { text:, header: true, parent: 'tbody' } }
  let(:component_css_class) { 'govuk-table__cell' }

  describe 'configuration' do
    describe 'disabling automatic scopes' do
      context "when enable_auto_table_scopes: true" do
        subject! { render_inline(GovukComponent::TableComponent::CellComponent.new(**kwargs)) }

        specify "renders a scopeless table cell" do
          expect(rendered_content).to have_tag("th", text: "Content")
          expect(html.at_css('th').attributes.keys).to match_array(%w(class scope))
        end
      end

      context "when enable_auto_table_scopes: false" do
        after { Govuk::Components.reset! }

        before do
          Govuk::Components.configure do |config|
            config.enable_auto_table_scopes = false
          end
        end

        subject! { render_inline(GovukComponent::TableComponent::CellComponent.new(**kwargs)) }

        specify "renders a scopeless table cell" do
          expect(rendered_content).to have_tag("th", text: "Content")
          expect(html.at_css('th').attributes.keys).to match_array(%w(class))
        end
      end
    end
  end
end
