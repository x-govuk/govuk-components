require 'spec_helper'

RSpec.describe(GovukComponent::SummaryListComponent, type: :component) do
  include_context 'helpers'
  include_context 'setup'

  let(:component_css_class) { 'govuk-summary-list' }

  let(:action_link_text) { 'Something' }
  let(:action_link_href) { '#anchor' }

  let(:rows) do
    [
      { key: 'One', value: 'The first item in the list' },
      { key: 'Two', value: 'The second item in the list' },
      { key: 'Three', value: 'The third item in the list', action: { href: action_link_href, text: action_link_text } },
    ]
  end

  let(:kwargs) { {} }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :row }
    let(:content) { nil }
    let(:slot_kwargs) { { key: 'key', value: 'value' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'

    specify 'rows are rendered with keys, values and actions' do
      render_inline(described_class.new) do |component|
        component.row(key: 'this key', value: 'this value')
        component.row(key: 'that key', value: 'that value', action: { href: '#change-this' })
        component.row(
          key: 'another key',
          value: 'another value',
          action: {
            href: '#do-something',
            text: 'Do',
            visually_hidden_text: 'something',
            classes: 'custom-class',
            html_attributes: { 'data-tag' => 'some-data' },
          },
        )
      end

      expect(rendered_component).to have_tag('dl', with: { class: 'govuk-summary-list' }) do
        with_tag('div', with: { class: 'govuk-summary-list__row' }) do
          with_tag('dt', with: { class: 'govuk-summary-list__key' }, text: 'this key')
          with_tag('dd', with: { class: 'govuk-summary-list__value' }, text: 'this value')
          with_tag('dd', with: { class: 'govuk-summary-list__actions' })
        end

        with_tag('div', with: { class: 'govuk-summary-list__row' }) do
          with_tag('dt', with: { class: 'govuk-summary-list__key' }, text: 'this key')
          with_tag('dd', with: { class: 'govuk-summary-list__value' }, text: 'this value')
          with_tag('dd', with: { class: 'govuk-summary-list__actions' }) do
            with_tag('a', with: { class: 'govuk-link', href: '#change-this' }, text: /Change/) do
              with_tag('span', with: { class: 'govuk-visually-hidden' }, text: ' that key')
            end
          end
        end

        with_tag('div', with: { class: 'govuk-summary-list__row' }) do
          with_tag('dt', with: { class: 'govuk-summary-list__key' }, text: 'another key')
          with_tag('dd', with: { class: 'govuk-summary-list__value' }, text: 'another value')
          with_tag('dd', with: { class: 'govuk-summary-list__actions' }) do
            with_tag('a', with: { class: 'govuk-link custom-class', href: '#do-something', 'data-tag' => 'some-data' }, text: /Do/) do
              with_tag('span', with: { class: 'govuk-visually-hidden' }, text: ' something')
            end
          end
        end
      end
    end
  end

  describe 'rendering a summary list with rows' do
    before do
      render_inline(described_class.new(**kwargs)) do |component|
        rows.each { |row| component.row(**row) }
      end
    end

    specify 'renders the summary list' do
      expect(rendered_component).to have_tag('dl', with: { class: 'govuk-summary-list' })
    end

    context 'when borders is false' do
      let(:kwargs) { { borders: false } }

      specify 'no borders class is appended' do
        expect(rendered_component).to have_tag('dl', with: { class: 'govuk-summary-list govuk-summary-list--no-border' })
      end
    end

    specify 'renders the correct number of rows' do
      expect(rendered_component).to have_tag('div', with: { class: 'govuk-summary-list__row' }, count: rows.size)
    end

    specify 'renders the correct content in the rows' do
      expect(rendered_component).to have_tag('dl', with: { class: 'govuk-summary-list' }) do
        rows.each do |row|
          with_tag('div', with: { class: 'govuk-summary-list__row' }) do
            with_tag('dt', with: { class: 'govuk-summary-list__key' }, text: row[:key])
            with_tag('dd', with: { class: 'govuk-summary-list__value' }, text: row[:value])
          end
        end
      end
    end
  end

  context 'when no actions are present' do
    before do
      render_inline(described_class.new(**kwargs)) do |component|
        rows.reject { |row| row.key?(:action) }.each { |row| component.row(**row) }
      end
    end

    specify 'actions column is not present' do
      expect(rendered_component).not_to have_tag('dd', with: { class: 'govuk-summary-list__actions' })
    end
  end
end
