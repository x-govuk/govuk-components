require 'spec_helper'

RSpec.describe(GovukComponent::PhaseBanner, type: :component) do
  let(:tag) { 'Gamma' }
  let(:text) { 'This is an experimental service – be cautious' }
  let(:component) { GovukComponent::PhaseBanner.new(tag: tag, text: text) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  context 'when text is supplied' do
    specify 'contains a phase banner with the correct tag and body text' do
      expect(subject).to have_css('div', class: %w(govuk-phase-banner)) do
        within('govuk-phase-banner__content') do
          expect(page).to have_css(
            'strong',
            class: %w(govuk-tag govuk-phase-banner__content__tag),
            text: tag
          )

          expect(page).to have_css(
            'span',
            class: %w(govuk-phase-banner__text),
            text: text
          )
        end
      end
    end
  end

  context 'when a block is supplied' do
    specify 'contains a phase banner with the correct tag and body html'
  end
end
