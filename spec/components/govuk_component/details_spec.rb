require 'spec_helper'

RSpec.describe(GovukComponent::Details, type: :component) do
  let(:summary) { 'The new Ribwich' }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  context 'when text is supplied' do
    let(:text) { 'Now without lettuce' }
    let(:component) { GovukComponent::Details.new(summary: summary, text: text) }

    specify 'contains a details element with the correct summary and text' do
      expect(subject).to have_css('details', class: %w(govuk-details)) do
        expect(page).to have_css('summary.govuk-details__summary > span.govuk-details__summary-text', text: summary)
        expect(page).to have_css('div.govuk-details__text', text: text, visible: false)
      end
    end
  end

  # This approach won't work until support for passing blocks to components in
  # tests is added, see https://github.com/github/view_component/issues/215
  xcontext 'when a block is supplied' do
    let(:content) { %(You're way off. Think smaller, and more legs.) }

    let(:content) do
      capture do
        content_tag('section') do
          concat(tag.strong(content))
        end
      end
    end

    let(:component) do
      GovukComponent::Details.new(summary: summary) { content }
    end

    specify 'contains a details element with the correct summary and text' do
      expect(subject).to have_css('details', class: %w(govuk-details)) do
        expect(page).to have_css('summary.govuk-details__summary > span.govuk-details__summary-text', text: summary)
        expect(page).to have_css('div.govuk-details__text > section > strong', text: content, visible: false)
      end
    end
  end
end
