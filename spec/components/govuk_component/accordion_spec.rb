require 'spec_helper'

RSpec.describe(GovukComponent::Accordion, type: :component) do
  include_context "helpers"

  let(:id) { 'fancy-accordion' }
  let(:sections) do
    {
      'section 1' => 'first section content',
      'section 2' => 'second section content',
      'section 3' => 'third section content'
    }
  end

  let(:kwargs) { { id: id } }

  subject! do
    render_inline(GovukComponent::Accordion.new) do |component|
      sections.each do |title, content|
        component.slot(:section, title: title) { content }
      end
    end
  end

  specify 'an accordion with the correct number of sections should be rendered' do
    expect(page).to have_css('div.govuk-accordion') do |accordion|
      expect(accordion).to have_css('.govuk-accordion__section', count: sections.size)
    end
  end

  context 'when an ID is set for the accordion' do
    subject! do
      render_inline(GovukComponent::Accordion.new(**kwargs))
    end

    specify 'the id should be set correctly' do
      expect(page).to have_css("##{id}")
    end
  end

  specify 'the sections should have the correct title and content' do
    sections.each do |title, content|
      expect(page).to have_css("##{title.parameterize}-section.govuk-accordion__section") do |section|
        expect(section).to have_css('.govuk-accordion__section-button', text: title)
        expect(section).to have_css('.govuk-accordion__section-content', text: content)
      end
    end
  end

  specify 'the section ids should match content aria-labelledby' do
    sections.each do |title, _|
      id = title.parameterize

      expect(page).to have_css('#' + id)
      expect(page).to have_css(%(div[aria-labelledby='#{id}']))
    end
  end

  describe 'summaries' do
    context 'when no summary is present' do
      specify 'no summary should be present' do
        expect(page).not_to have_css('.govuk-accordion__section-summary')
      end
    end

    context 'when a summary is present' do
      let(:title) { 'summary' }
      let(:summary_content) { 'summary content' }
      subject! do
        render_inline(GovukComponent::Accordion.new) do |component|
          component.slot(:section, title: title, summary: summary_content) { 'abc' }
        end
      end

      specify 'the summary should be present and have the correct id and classes' do
        expect(page).to have_css("##{title}-summary.govuk-accordion__section-summary", text: summary_content)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :section }
    let(:content) { -> { 'some swanky accordion content' } }
    let(:slot_kwargs) { { title: 'A title', summary: 'A summary' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end

  it_behaves_like 'a component with a DSL wrapper' do
    let(:helper_name) { 'govuk_accordion' }
    let(:wrapped_slots) { %i(section) }
    let(:block) { nil }

    let(:expected_css) { '.govuk-accordion' }
  end
end
