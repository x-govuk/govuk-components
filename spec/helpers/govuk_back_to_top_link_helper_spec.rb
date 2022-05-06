require 'spec_helper'

RSpec.describe(GovukBackToTopLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

  describe '#govuk_back_to_top_link' do
    subject { govuk_back_to_top_link }
    let(:expected_classes) { %w(govuk-link govuk-link--no-visited-state) }

    it "renders a back to top link" do
      expect(subject).to have_tag('a', with: { href: '#top', class: expected_classes }, text: /Back to top/) do
        with_tag('svg')
      end
    end

    context "when the target is overridden" do
      subject { govuk_back_to_top_link("#pinacle") }

      it "renders a back to top link with a custom target" do
        expect(subject).to have_tag('a', with: { href: '#pinacle' })
      end
    end
  end
end
