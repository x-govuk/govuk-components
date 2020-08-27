require 'spec_helper'

RSpec.describe(GovukComponent::Warning, type: :component) do
  let(:text) { 'Some warning' }
  let(:icon_fallback_text) { 'Some warning' }
  let(:kwargs) { { text: text } }

  context 'default behaviour' do
    before { render_inline(GovukComponent::Warning.new(**kwargs)) }

    context 'containing div' do
      subject { page.find('.govuk-warning-text') }

      it { is_expected.to have_css('span', class: 'govuk-warning-text__icon', text: '!') }
    end

    context 'strong tag' do
      subject { page.find('.govuk-warning-text > strong.govuk-warning-text__text') }

      it { is_expected.to have_css('span', class: 'govuk-warning-text__assistive', text: 'Warning') }
      it { is_expected.to have_text text }
    end
  end

  context 'with custom warning text' do
    before { render_inline(GovukComponent::Warning.new(**kwargs.merge(icon_fallback_text: icon_fallback_text))) }

    context 'strong tag' do
      subject { page.find('.govuk-warning-text > strong.govuk-warning-text__text') }

      it { is_expected.to have_css('span', class: 'govuk-warning-text__assistive', text: icon_fallback_text) }
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
