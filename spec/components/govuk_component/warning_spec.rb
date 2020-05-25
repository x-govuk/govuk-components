require 'spec_helper'

RSpec.describe(GovukComponent::Warning, type: :component) do
  let(:node) { Capybara::Node::Simple.new(render_inline(component).to_html) }
  let(:text) { 'Some warning' }

  context 'default behaviour' do
    let(:component) { GovukComponent::Warning.new(text: text) }

    context 'containing div' do
      subject { node.find('.govuk-warning-text') }
      it { is_expected.to have_css('span', class: 'govuk-warning-text__icon', text: '!') }
    end

    context 'strong tag' do
      subject { node.find('.govuk-warning-text > strong.govuk-warning-text__text') }
      it { is_expected.to have_css('span', class: 'govuk-warning-text__assistive', text: 'Warning') }
      it { is_expected.to have_text text }
    end
  end

  context 'with custom warning text' do
    let(:icon_fallback_text) { 'Custom fallback text' }
    let(:component) { GovukComponent::Warning.new(text: text, icon_fallback_text: icon_fallback_text) }

    context 'strong tag' do
      subject { node.find('.govuk-warning-text > strong.govuk-warning-text__text') }
      it { is_expected.to have_css('span', class: 'govuk-warning-text__assistive', text: icon_fallback_text) }
    end
  end

  context 'with custom classes' do
    let(:component) { GovukComponent::Warning.new(text: text, classes: %w(custom-class)) }
    subject { node }
    it { is_expected.to have_css('.govuk-warning-text.custom-class') }
  end
end
