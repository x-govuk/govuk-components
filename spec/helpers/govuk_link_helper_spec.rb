require 'spec_helper'

RSpec.describe(GovukLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper

  let(:text) { 'Menu' }
  let(:url) { '/stuff/menu/' }
  subject { Capybara::Node::Simple.new(component) }

  describe '#govuk_link_to' do
    let(:component) { govuk_link_to(text, url) }
    it { is_expected.to(have_link(text, href: url, class: 'govuk-link')) }

    context 'when additional classes are passed in' do
      let(:custom_class) { 'yellow' }
      let(:component) { govuk_link_to(text, url, class: custom_class) }

      specify 'has the custom classes' do
        expect(subject).to(have_link(text, href: url, class: [custom_class]))
      end

      specify 'does not have the default class' do
        expect(subject).not_to(have_link(text, href: url, class: 'govuk-link'))
      end
    end

    context 'when additional classes are passed in as arrays' do
      let(:custom_class) { %w(yellow) }
      let(:component) { govuk_link_to(text, url, class: custom_class) }

      specify 'has the custom classes' do
        expect(subject).to(have_link(text, href: url, class: custom_class))
      end
    end
  end
end
