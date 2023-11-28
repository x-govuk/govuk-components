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
  end
end
