require 'spec_helper'

RSpec.describe(GovukLinkHelper, type: 'helper') do
  let(:text) { 'Menu' }
  let(:url) { '/stuff/menu/' }
  describe '#govuk_link_to' do
    let(:component) { govuk_link_to(text, url) }
    subject { Capybara::Node::Simple.new(component) }
    it { is_expected.to(have_link(text, href: url, class: 'govuk-link')) }
  end
end
