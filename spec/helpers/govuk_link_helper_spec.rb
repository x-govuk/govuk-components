require 'spec_helper'

RSpec.describe(GovukLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

  let(:text) { 'Menu' }
  subject { Capybara::Node::Simple.new(component) }

  describe '#govuk_link_to' do
    let(:url) { '/stuff/menu/' }
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

    context 'when provided with a block' do
      let(:link_text) { 'Onwards!' }
      let(:link_html) { tag.span(link_text) }
      let(:component) { govuk_link_to(url) { link_html } }

      specify 'should render a link containing the block content' do
        expect(subject).to have_css('a > span', text: link_text)
      end
    end
  end

  describe '#govuk_mail_to' do
    let(:email_address) { %(test@something.org) }
    let(:target) { %(mailto:) + email_address }
    let(:component) { govuk_mail_to(email_address, text) }
    it { is_expected.to(have_link(text, href: target, class: 'govuk-link')) }

    context 'when additional classes are passed in' do
      let(:custom_class) { 'yellow' }
      let(:component) { govuk_mail_to(email_address, text, class: custom_class) }

      specify 'has the custom classes' do
        expect(subject).to(have_link(text, href: target, class: [custom_class]))
      end

      specify 'does not have the default class' do
        expect(subject).not_to(have_link(text, href: target, class: 'govuk-link'))
      end
    end

    context 'when additional classes are passed in as arrays' do
      let(:custom_class) { %w(yellow) }
      let(:component) { govuk_mail_to(email_address, text, class: custom_class) }

      specify 'has the custom classes' do
        expect(subject).to(have_link(text, href: target, class: custom_class))
      end
    end

    context 'when provided with a block' do
      let(:link_text) { 'Contact us!' }
      let(:link_html) { tag.span(link_text) }
      let(:component) { govuk_mail_to(email_address) { link_html } }

      specify 'should render a link containing the block content' do
        expect(subject).to have_css('a > span', text: link_text)
      end
    end
  end

  describe '#govuk_button_to' do
    let(:url) { '/stuff/menu/' }
    let(:component) { govuk_button_to(text, url) }
    it { is_expected.to(have_button(text, class: 'govuk-button')) }

    specify 'has form with correct url containing submit input with supplied text' do
      expect(subject).to have_css(%(form)) do |form|
        expect(form['action']).to eql(url)
        expect(form).to have_button(text, class: 'govuk-button')
      end
    end

    context 'when additional classes are passed in' do
      let(:custom_class) { 'yellow' }
      let(:component) { govuk_button_to(text, url, class: custom_class) }

      specify 'has the custom classes' do
        expect(subject).to(have_button(text, class: [custom_class]))
      end

      specify 'does not have the default class' do
        expect(subject).not_to(have_button(text, class: 'govuk-button'))
      end
    end

    context 'when additional classes are passed in as arrays' do
      let(:custom_class) { %w(yellow) }
      let(:component) { govuk_button_to(text, url, class: custom_class) }

      specify 'has the custom classes' do
        expect(subject).to(have_button(text, class: custom_class))
      end
    end
  end
end
