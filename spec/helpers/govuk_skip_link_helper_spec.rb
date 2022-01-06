require 'spec_helper'

RSpec.describe(GovukSkipLinkHelper, type: 'helper') do
  include ActionView::Context
  include ActionView::Helpers::UrlHelper

  let(:custom_link_text) { 'Get straight to the important stuff' }
  let(:custom_href) { '#skip-link-target' }

  let(:default_href) { '#main-content' }
  let(:default_link_text) { 'Skip to main content' }

  describe '#govuk_skip_link' do
    let(:expected) { { href: default_href, class: %w(govuk-skip-link), "data-module" => "govuk-skip-link" } }

    context 'when text not provided' do
      subject { govuk_skip_link }
      it { is_expected.to have_tag('a', with: expected, text: default_link_text) }
    end

    context 'when text provided' do
      subject { govuk_skip_link(text: custom_link_text) }
      it { is_expected.to have_tag('a', with: expected, text: custom_link_text) }
    end

    context 'when href not provided' do
      subject { govuk_skip_link }
      it { is_expected.to have_tag('a', with: expected, text: default_link_text) }
    end

    context 'when href provided' do
      subject { govuk_skip_link(href: custom_href) }
      it { is_expected.to have_tag('a', with: expected.merge(href: custom_href), text: default_link_text) }
    end

    describe 'extra classes' do
      context 'when supplied with extra classes as a string' do
        let(:custom_classes) { 'pink' }
        subject { govuk_skip_link(classes: custom_classes) }
        it { is_expected.to have_tag('a', with: expected.deep_merge(class: Array.wrap(custom_classes)), text: default_link_text) }
      end

      context 'when supplied with extra classes as an array' do
        let(:custom_classes) { %w(yellow spots) }
        subject { govuk_skip_link(classes: custom_classes) }
        it { is_expected.to have_tag('a', with: expected.deep_merge(class: custom_classes), text: default_link_text) }
      end
    end

    describe 'custom html attributes' do
      let(:custom_attributes) { { lang: "en-GB", data: { awesome: "yes" } } }
      subject { govuk_skip_link(**custom_attributes) }
      it { is_expected.to have_tag('a', with: expected.deep_merge("data-awesome" => "yes"), text: default_link_text) }
    end

    describe 'custom HTML' do
      let(:custom_text) { "skip to the content" }
      let(:custom_class) { "yellow" }
      subject { govuk_skip_link { tag.span(custom_text, class: custom_class) } }

      it "inserts the custom HTML into the anchor element" do
        expect(subject).to have_tag('a', with: expected) do
          with_tag('span', with: { class: "yellow" }, text: custom_text)
        end
      end
    end
  end
end
