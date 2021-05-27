require 'spec_helper'

RSpec.describe(GovukComponent::DetailsComponent, type: :component, version: 2) do
  include_context 'helpers'
  include_context 'setup'

  let(:component_css_class) { 'govuk-details' }
  let(:summary_text) { 'The new Ribwich' }
  let(:text) { 'Now without lettuce' }
  let(:kwargs) { { summary_text: summary_text, text: text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'when text is supplied' do
    before { render_inline(described_class.new(**kwargs)) }

    specify 'contains a details element with the correct summary and text' do
      expect(rendered_component).to have_tag('details', with: { class: 'govuk-details', 'data-module' => 'govuk-details' }) do
        with_tag('summary', with: { class: 'govuk-details__summary' }) do
          with_tag('span', with: { class: 'govuk-details__summary-text' }, text: summary_text)
        end

        with_tag('div', with: { class: 'govuk-details__text' }, text: text)
      end
    end
  end

  context 'when a block is supplied' do
    before do
      render_inline(described_class.new(**kwargs.except(:text))) do
        helper.safe_join([
          helper.tag.h2('A heading', class: 'govuk-heading-m'),
          helper.tag.div('with a div', class: 'special-class'),
        ])
      end
    end

    specify 'contains a details element with the correct summary and text' do
      expect(rendered_component).to have_tag('details', with: { class: 'govuk-details', 'data-module' => 'govuk-details' }) do
        with_tag('summary', with: { class: 'govuk-details__summary' }) do
          with_tag('span', with: { class: 'govuk-details__summary-text' }, text: summary_text)
        end

        with_tag('div', with: { class: 'govuk-details__text' }) do
          with_tag('h2', with: { class: 'govuk-heading-m' }, text: 'A heading')
          with_tag('div', with: { class: 'special-class' }, text: 'with a div')
        end
      end
    end
  end
end
