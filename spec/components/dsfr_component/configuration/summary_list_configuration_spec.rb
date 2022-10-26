require 'spec_helper'

RSpec.describe(DsfrComponent::SummaryListComponent, type: :component) do
  describe 'configuration' do
    after { Dsfr::Components.reset! }

    describe 'default_summary_list_borders' do
      before do
        Dsfr::Components.configure do |config|
          config.default_summary_list_borders = false
        end
      end

      subject! { render_inline(DsfrComponent::SummaryListComponent.new) }

      specify "renders the borders based on the config setting" do
        expect(rendered_content).to have_tag("dl", with: { class: "govuk-summary-list--no-border" })
      end
    end

    describe 'require_summary_list_action_visually_hidden_text' do
      before do
        Dsfr::Components.configure do |config|
          config.require_summary_list_action_visually_hidden_text = true
        end
      end

      context "when visually_hidden_text is supplied" do
        let(:visually_hidden_text) { "visually hidden info" }
        subject! do
          render_inline(DsfrComponent::SummaryListComponent.new) do |sl|
            sl.row do |row|
              row.key(text: "key one")
              row.value(text: "value one")
              row.action(text: "action one", href: "/action-one", visually_hidden_text: visually_hidden_text)
            end
          end
        end

        specify "renders a span with the visually hidden text" do
          expect(rendered_content).to have_tag("span", text: visually_hidden_text, with: { class: "govuk-visually-hidden" })
        end
      end

      context "when visually_hidden_text is omitted" do
        subject do
          render_inline(DsfrComponent::SummaryListComponent.new) do |sl|
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
end
