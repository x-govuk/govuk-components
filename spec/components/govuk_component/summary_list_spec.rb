require 'spec_helper'

RSpec.describe(GovukComponent::SummaryList, type: :component) do
  include_context 'helpers'

  let(:action_link_text) { 'Something' }
  let(:action_link_href) { '#anchor' }
  let(:action_link) { helper.link_to(action_link_text, action_link_href) }

  let(:rows) do
    [
      { key: 'One', value: 'The first item in the list' },
      { key: 'Two', value: 'The second item in the list' },
      { key: 'Three', value: 'The third item in the list', action: action_link }
    ]
  end

  let(:kwargs) { {} }

  subject! do
    render_inline(GovukComponent::SummaryList.new(**kwargs)) do |component|
      rows.each { |row| component.slot(:row, **row) }
    end
  end

  specify 'the summary list should be present' do
    expect(page).to have_css('dl.govuk-summary-list')
  end

  specify 'the summary list should have the correct number of entries' do
    expect(page).to have_css('.govuk-summary-list__row', count: rows.size)
  end

  specify 'the entries should contain the correct content' do
    expect(page).to have_css('dl.govuk-summary-list') do |dl|
      rows.each do |row|
        expect(page).to have_css('.govuk-summary-list__row > dt.govuk-summary-list__key', text: row[:key])
        expect(page).to have_css('.govuk-summary-list__row > dd.govuk-summary-list__value', text: row[:value])
      end
    end
  end

  describe 'actions' do
    context 'when actions are absent' do
      let(:rows_without_actions) { rows.select { |row| !row.has_key?(:action) } }

      specify %(rows without actions should not have an action 'description details' tag) do
        rows_without_actions.each do |row|
          expect(page.find('div', text: /#{row[:key]}/)).not_to have_css('.govuk-summary-list__actions')
        end
      end
    end

    context 'when actions are present' do
      let(:rows_with_actions) { rows.select { |row| row.has_key?(:action) } }

      specify %(rows with actions should have an action 'description details' tag with the correct content) do
        rows_with_actions.each do |row|
          element = page.find('div', text: /#{row[:key]}/)

          expect(element).to have_css('.govuk-summary-list__actions')
          expect(element).to have_link(action_link_text, href: action_link_href)
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes' do
    let(:component_class) { described_class }
  end
end

