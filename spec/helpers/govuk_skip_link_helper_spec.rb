require 'spec_helper'

RSpec.describe(GovukSkipLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper

  let(:custom_link_text) { 'Get straight to the important stuff' }
  let(:custom_href) { '#skip-link-target' }

  let(:default_href) { '#main-content' }
  let(:default_link_text) { 'Skip to main content' }

  describe '#govuk_skip_link' do
    context 'when text not provided' do
      subject { govuk_skip_link }
      it { is_expected.to have_tag('a', with: { href: default_href, class: 'govuk-skip-link' }, text: default_link_text) }
    end

    context 'when text provided' do
      subject { govuk_skip_link text: custom_link_text }
      it { is_expected.to have_tag('a', with: { href: default_href, class: 'govuk-skip-link' }, text: custom_link_text) }
    end

    context 'when href not provided' do
      subject { govuk_skip_link }
      it { is_expected.to have_tag('a', with: { href: default_href, class: 'govuk-skip-link' }, text: default_link_text) }
    end

    context 'when href provided' do
      subject { govuk_skip_link href: custom_href }
      it { is_expected.to have_tag('a', with: { href: custom_href, class: 'govuk-skip-link' }, text: default_link_text) }
    end
  end
end
