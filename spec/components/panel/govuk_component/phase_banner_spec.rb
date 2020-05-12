require 'spec_helper'

RSpec.describe(GovukComponent::PhaseBanner, type: :component) do
  let(:tag) { 'Gamma' }
  let(:text) { 'This is an experimental service – be cautious' }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  context 'when text is supplied' do
    let(:component) { GovukComponent::PhaseBanner.new(tag: tag, text: text) }

    specify 'contains a phase banner with the correct tag and body text' do
      expect(subject).to have_css('div', class: %w(govuk-phase-banner)) do |div|
        expect(div).to have_css('p', class: %w(govuk-phase-banner__content)) do |p|
          expect(p).to have_css('strong', class: %w(govuk-phase-banner__content__tag), text: tag)
          expect(p).to have_css('span', class: %w(govuk-phase-banner__text), text: text)
        end
      end
    end
  end

  # This approach won't work until support for passing blocks to components in
  # tests is added, see https://github.com/github/view_component/issues/215
  xcontext 'when a block is supplied' do
    let(:warning) { 'This is an Alpha project, ignore everything' }

    let(:content) do
      capture do
        content_tag('section') do
          concat(tag.strong(warning))
        end
      end
    end

    let(:component) do
      GovukComponent::PhaseBanner.new(tag: tag) { content }
    end

    specify 'contains a phase banner with the correct tag and body html' do
      expect(subject).to have_css('div', class: %w(govuk-phase-banner)) do |div|
        expect(div).to have_css('p', class: %w(govuk-phase-banner__content)) do |p|
          expect(p).to have_css('strong', class: %w(govuk-phase-banner__content__tag), text: tag)
          expect(p).to have_css('span', class: %w(govuk-phase-banner__text)) do |span|
            expect(span).to have_css('strong', text: warning)
          end
        end
      end
    end
  end
end
