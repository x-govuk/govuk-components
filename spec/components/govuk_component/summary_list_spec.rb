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
        expect(dl).to have_css('.govuk-summary-list__row > dt.govuk-summary-list__key', text: row[:key])
        expect(dl).to have_css('.govuk-summary-list__row > dd.govuk-summary-list__value', text: row[:value])
      end
    end
  end

  describe 'actions' do
    context 'when no actions are present' do
      subject! do
        render_inline(GovukComponent::SummaryList.new(**kwargs)) do |component|
          rows
            .reject { |row| row.key?(:action) }
            .each { |row| component.slot(:row, **row) }
        end
      end

      specify %(there should be no actions column) do
        expect(page).not_to have_css('.govuk-summary-list__actions')
      end
    end

    context 'when actions are present' do
      let(:rows_with_actions) { rows.select { |row| row.key?(:action) } }

      specify 'all rows should have an actions column' do
        expect(page).to have_css('.govuk-summary-list__actions', count: rows.size)
      end

      specify %(rows with actions should have an actions column with the supplied content) do
        rows_with_actions.each do |row|
          element = page.find('div', text: /#{row[:key]}/)

          expect(element).to have_css('.govuk-summary-list__actions')
          expect(element).to have_link(action_link_text, href: action_link_href)
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :row }
    let(:content) { nil }
    let(:slot_kwargs) { { key: 'key', value: 'value' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end

  it_behaves_like 'a component with a DSL wrapper' do
    let(:helper_name) { 'govuk_summary_list' }
    let(:wrapped_slots) { %i(row) }
    let(:block) { nil }

    let(:expected_css) { '.govuk-summary-list' }
  end
end
