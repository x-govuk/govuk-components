require 'spec_helper'

RSpec.describe(GovukVisuallyHiddenHelper, type: 'helper') do
  include ActionView::Context
  include ActionView::Helpers::UrlHelper

  describe '#govuk_visually_hidden' do
    context 'when text is blank' do
      subject { govuk_visually_hidden("") }
      it { is_expected.to be_nil }
    end

    context 'when text is provided' do
      subject { govuk_visually_hidden("first item") }

      it { is_expected.to have_tag('span', with: { class: "govuk-visually-hidden" }, text: "first item") }
    end

    context 'when text is provided as a block' do
      subject { govuk_visually_hidden { "first item" } }

      it { is_expected.to have_tag('span', with: { class: "govuk-visually-hidden" }, text: "first item") }
    end

    context 'when a custom brand is set' do
      let(:custom_brand) { 'globex-corp' }

      before do
        Govuk::Components.configure do |conf|
          conf.brand = custom_brand
        end
      end

      after do
        Govuk::Components.reset!
      end

      subject { govuk_visually_hidden("first item") }

      it { is_expected.to have_tag('span', with: { class: "#{custom_brand}-visually-hidden" }) }
    end
  end
end
