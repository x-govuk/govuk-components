require 'spec_helper'

RSpec.describe(GovukComponent::PhaseBanner, type: :component) do
  let(:phase) { 'Gamma' }
  let(:text) { 'This is an experimental service – be cautious' }
  let(:kwargs) { { phase_tag: { text: phase }, text: text } }

  subject! { render_inline(GovukComponent::PhaseBanner.new(**kwargs)) }

  context 'when text is supplied' do
    specify 'contains a phase banner with the correct phase and body text' do
      expect(page).to have_css('div', class: %w(govuk-phase-banner)) do |div|
        expect(div).to have_css('p', class: %w(govuk-phase-banner__content)) do |p|
          expect(p).to have_css('strong', class: %w(govuk-phase-banner__content__tag), text: phase)
          expect(p).to have_css('span', class: %w(govuk-phase-banner__text), text: text)
        end
      end
    end
  end

  context 'when a block is supplied' do
    let(:content) { 'Ignore everything' }

    subject! do
      render_inline(GovukComponent::PhaseBanner.new(**kwargs.except(:text))) { content }
    end

    specify 'contains a phase banner with the correct tag and body html' do
      expect(page).to have_css('div', class: %w(govuk-phase-banner)) do |div|
        expect(div).to have_css('p', class: %w(govuk-phase-banner__content)) do |p|
          expect(p).to have_css('strong', class: %w(govuk-phase-banner__content__tag), text: phase)
          expect(p).to have_css('span', class: %w(govuk-phase-banner__text)) do |span|
            expect(span).to have_content(content)
          end
        end
      end
    end
  end

  context 'customising the tag colour' do
    let(:kwargs) { { phase_tag: { text: phase, colour: 'orange' }, text: text } }

    specify 'the tag should have the custom colour class' do
      expect(page).to have_css('strong', class: %w(govuk-tag--orange), text: phase)
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
