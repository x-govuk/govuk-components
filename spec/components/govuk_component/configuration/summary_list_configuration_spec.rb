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

    describe 'require_summary_list_action_visually_hidden_text' do
      before do
        Govuk::Components.configure do |config|
          config.require_summary_list_action_visually_hidden_text = true
        end
      end

      subject do
        render_inline(GovukComponent::SummaryListComponent.new) do |sl|
          sl.row do |row|
            row.key(text: "key one")
            row.value(text: "value one")
            row.action(text: "action one", href: "/action-one")
          end
        end
      end

      specify "raises an error when no visually hidden text is supplied" do
        expect { subject }.to raise_error(ArgumentError, "missing keyword: visually_hidden_text")
      end
    end
  end
end
