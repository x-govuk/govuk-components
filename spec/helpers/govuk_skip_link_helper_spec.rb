require 'spec_helper'

RSpec.describe(GovukSkipLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper

  let(:text) { 'Get straight to the important stuff' }
  let(:href) { '#skip-link-target' }
  subject { Capybara::Node::Simple.new(component) }

  describe '#govuk_skip_link' do
    context 'when text not provided' do
      let(:component) { govuk_skip_link }
      it { is_expected.to(have_link('Skip to main content', href: '#main-content', class: 'govuk-skip-link')) }
    end

    context 'when text provided' do
      let(:component) { govuk_skip_link text: text }
      it { is_expected.to(have_link(text, href: '#main-content', class: 'govuk-skip-link')) }
    end

    context 'when href not provided' do
      let(:component) { govuk_skip_link }
      it { is_expected.to(have_link('Skip to main content', href: '#main-content', class: 'govuk-skip-link')) }
    end

    context 'when href provided' do
      let(:component) { govuk_skip_link href: href }
      it { is_expected.to(have_link('Skip to main content', href: href, class: 'govuk-skip-link')) }
    end
  end
end
