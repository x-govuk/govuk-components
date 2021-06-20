require 'spec_helper'

RSpec.describe(GovukLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

  let(:text) { 'Menu' }
  let(:url) { '/stuff/menu/' }
  let(:args) { [text, url] }
  let(:kwargs) { {} }

  describe '#govuk_link_classes' do
    subject { govuk_link_classes(**kwargs) }

    describe "by default" do
      let(:kwargs) { {} }

      specify "contains only 'govuk-link'" do
        expect(subject).to eql(%w(govuk-link))
      end
    end

    {
      no_visited_state: 'govuk-link--no-visited-state',
      muted:            'govuk-link--muted',
      text_colour:      'govuk-link--text-colour',
      inverse:          'govuk-link--inverse',
      no_underline:     'govuk-link--no-underline',
    }.each do |style, css_class|
      describe "generating a #{style}-style link with '#{style}: true'" do
        let(:kwargs) { { style => true } }

        specify %(contains 'govuk-link' and '#{css_class}') do
          expect(subject).to match_array(['govuk-link', css_class])
        end
      end
    end
  end

  describe '#govuk_button_classes' do
    subject { govuk_button_classes(**kwargs) }

    describe "by default" do
      let(:kwargs) { {} }

      specify "contains only 'govuk-link'" do
        expect(subject).to eql(%w(govuk-button))
      end
    end

    {
      secondary: 'govuk-button--secondary',
      warning:   'govuk-button--warning',
      disabled:  'govuk-button--disabled',
    }.each do |style, css_class|
      describe "generating a #{style}-style button with '#{style}: true'" do
        let(:kwargs) { { style => true } }

        specify %(contains 'govuk-button' and '#{css_class}') do
          expect(subject).to match_array(['govuk-button', css_class])
        end
      end
    end
  end
end
