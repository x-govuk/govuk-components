require 'spec_helper'

RSpec.describe(DsfrComponent::DetailsComponent, type: :component) do
  let(:component_css_class) { 'govuk-details' }
  let(:summary_text) { 'The new Ribwich' }
  let(:text) { 'Now without lettuce' }
  let(:kwargs) { { summary_text: summary_text, text: text } }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'when text is supplied' do
    before { render_inline(described_class.new(**kwargs)) }

    specify 'contains a details element with the correct summary and text' do
      expect(rendered_content).to have_tag('details', with: { class: 'govuk-details', 'data-module' => 'govuk-details' }) do
        with_tag('summary', with: { class: 'govuk-details__summary' }) do
          with_tag('span', with: { class: 'govuk-details__summary-text' }, text: summary_text)
        end

        with_tag('div', with: { class: 'govuk-details__text' }, text: text)
      end
    end
  end

  context 'providing summary HTML' do
    let(:summary_tag) { "em" }
    let(:summary_text) { "Fancy summary" }
    let(:summary_html) { helper.content_tag(summary_tag, summary_text) }

    before do
      render_inline(described_class.new(**kwargs)) do |component|
        component.summary_html { summary_html }
      end
    end

    specify 'renders the HTML correctly' do
      expect(rendered_content).to have_tag("span", with: { class: "govuk-details__summary-text" }) do
        with_tag(summary_tag, text: summary_text)
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
      expect(rendered_content).to have_tag('details', with: { class: 'govuk-details', 'data-module' => 'govuk-details' }) do
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

  context 'setting the id' do
    let(:custom_id) { 'abc123' }
    before do
      render_inline(described_class.new(**kwargs.merge(id: custom_id))) {}
    end

    specify 'rendered details element has the custom id' do
      expect(rendered_content).to have_tag('details', with: { id: custom_id, class: component_css_class })
    end
  end

  context 'overriding the open status' do
    before do
      render_inline(described_class.new(**kwargs.merge(open: true))) {}
    end

    specify 'rendered details element has the custom id' do
      expect(rendered_content).to have_tag('details', with: { open: 'open', class: component_css_class })
    end
  end
end
