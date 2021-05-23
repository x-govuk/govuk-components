require 'spec_helper'

RSpec.describe(GovukComponent::AccordionComponent, type: :component, version: 2) do
  include_context 'helpers'
  include_context 'setup'

  let(:id) { 'fancy-accordion' }
  let(:component_css_class) { 'govuk-accordion' }

  let(:sections) do
    {
      'section 1' => 'first section content',
      'section 2' => 'second section content',
      'section 3' => 'third section content'
    }
  end

  let(:kwargs) { { id: id } }

  subject! do
    render_inline(GovukComponent::AccordionComponent.new) do |component|
      sections.each do |title, content|
        component.section(title: title) { content }
      end
    end
  end

  specify 'renders an container div with the right class' do
    expect(rendered_component).to have_tag('div', with: { class: component_css_class }) do
      with_tag('div', with: { class: 'govuk-accordion__section' })
    end
  end

  context 'when a custom ID is provided' do
    before do
      render_inline(GovukComponent::AccordionComponent.new(**kwargs))
    end

    specify 'the container div has the right id' do
      expect(rendered_component).to have_tag('div', with: { id: id, class: component_css_class })
    end
  end

  describe 'for each section' do
    specify 'the title and content is present' do
      sections.each do |title, content|
        expect(rendered_component).to have_tag('div', with: { class: 'govuk-accordion__section', id: %(#{title.parameterize}-section) }) do
          with_tag('span', with: { id: title.parameterize, class: 'govuk-accordion__section-button' })
          with_text(content)
        end
      end
    end

    specify 'the section ID matches the content aria-labelledby' do
      sections.each_key do |title|
        id = title.parameterize

        expect(rendered_component).to have_tag('span', with: { id: id, class: 'govuk-accordion__section-button' })
        expect(rendered_component).to have_tag('div', with: { 'aria-labelledby' => id })
      end
    end

    specify 'the section IDs match the button aria-controls' do
      sections.each_key do |title|
        id = title.parameterize

        expect(rendered_component).to have_tag('span', with: { id: id, class: 'govuk-accordion__section-button' })
        expect(rendered_component).to have_tag('span', with: { 'aria-controls' => %(#{id}-content) })
      end
    end
  end

  describe 'summaries' do
    specify 'no summary by default' do
      expect(rendered_component).not_to have_tag('.govuk-accordion__section-summary')
    end

    context 'when a summary text is provided' do
      let(:title) { 'a thing' }
      let(:summary_content) { 'some summary content' }
      let(:expected_classes) { %w(govuk-accordion__section-summary govuk-body) }

      subject! do
        render_inline(GovukComponent::AccordionComponent.new) do |component|
          component.section(title: title, summary: summary_content) { 'abc' }
        end
      end

      specify 'the summary is rendered with the right id, class and text' do
        expect(rendered_component).to have_tag('.govuk-accordion__section-header') do
          with_tag('div', with: { id: %(#{title.parameterize}-summary), class: expected_classes }, text: summary_content)
        end
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

    specify 'sections have the correct expanded states' do
      render_inline(GovukComponent::AccordionComponent.new) do |component|
        component.section(expanded: true, title: 'section 1', html_attributes: { id: 'section_1' }) { 'abc' }
        component.section(title: 'section 2', html_attributes: { id: 'section_2' }) { 'def' }
      end

      expect(rendered_component).to have_tag('#section_1.govuk-accordion__section.govuk-accordion__section--expanded')
      expect(rendered_component).to have_tag('#section_2.govuk-accordion__section')
      expect(rendered_component).to have_tag('span#section-1[aria-expanded="true"]')
      expect(rendered_component).to have_tag('span#section-2[aria-expanded="false"]')

      expect(rendered_component).not_to have_tag('#section_2.govuk-accordion__section.govuk-accordion__section--expanded')
    end
  end
end
