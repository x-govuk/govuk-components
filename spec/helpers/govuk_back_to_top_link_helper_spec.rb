require 'spec_helper'

RSpec.describe(GovukBackToTopLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper
  include ActionView::Context
  subject { Capybara::Node::Simple.new(component) }

  describe '#govuk_back_to_top_link' do
    let(:component) { govuk_back_to_top_link }

    it { is_expected.to(have_link('Back to top', href: '#top', class: 'govuk-link govuk-link--no-visited-state')) }
  end
end
