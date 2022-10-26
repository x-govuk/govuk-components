require 'spec_helper'

RSpec.describe(DsfrComponent::AccordionComponent, type: :component) do
  let(:id) { 'fancy-accordion' }
  let(:component_css_class) { 'govuk-accordion' }

  let(:sections) do
    {
      'section 1' => 'first section content',
      'section 2' => 'second section content',
      'section 3' => 'third section content'
    }
  end

  let(:kwargs) { { html_attributes: { id: id } } }

  subject! do
    render_inline(DsfrComponent::AccordionComponent.new(**kwargs)) do |component|
      helper.safe_join(
        sections.map do |heading_text, content|
          component.section(heading_text: heading_text) { content }
        end
      )
    end
  end

  specify 'renders a container div with the right class' do
    expect(rendered_content).to have_tag('div', with: { class: component_css_class }) do
      with_tag('div', with: { class: 'govuk-accordion__section' })
    end
  end

  context 'when a custom ID is provided' do
    before do
      render_inline(DsfrComponent::AccordionComponent.new(**kwargs))
    end

    specify 'the container div has the right id' do
      expect(rendered_content).to have_tag('div', with: { id: id, class: component_css_class })
    end
  end

  describe 'for each section' do
    specify 'the heading text and content is present' do
      sections.each do |heading_text, content|
        expect(rendered_content).to have_tag('div', with: { class: 'govuk-accordion__section', id: %(#{heading_text.parameterize}-section) }) do
          with_tag('h2', class: 'govuk-accordion__section-heading') do
            with_tag('span', text: heading_text, with: { id: heading_text.parameterize, class: 'govuk-accordion__section-button' })
          end

          with_tag('div', with: { id: %(#{heading_text.parameterize}-content), class: 'govuk-accordion__section-content' }, text: content)
        end
      end
    end

    specify 'each section ID matches the content aria-labelledby' do
      sections.each_key do |heading_text|
        id = heading_text.parameterize

        expect(rendered_content).to have_tag('span', with: { id: id, class: 'govuk-accordion__section-button' })
        expect(rendered_content).to have_tag('div', with: { 'aria-labelledby' => id })
      end
    end

    specify 'each section ID matches the button aria-controls' do
      sections.each_key do |heading_text|
        id = heading_text.parameterize

        expect(rendered_content).to have_tag('div', with: { id: %(#{id}-content) })
        expect(rendered_content).to have_tag('span', with: { 'aria-controls' => %(#{id}-content) })
      end
    end
  end

  describe 'overriding the section heading level' do
    let(:kwargs) { { heading_level: 3 } }

    specify 'has the overriden level' do
      expect(rendered_content).to have_tag('h3', with: { class: 'govuk-accordion__section-heading' })
    end

    context 'when the heading level is invalid' do
      specify 'has the overriden level' do
        expected_message = "heading_level must be 1-6"

        expect { DsfrComponent::AccordionComponent.new(heading_level: 8) }.to raise_error(ArgumentError, expected_message)
      end
    end
  end

  describe 'overriding the section heading with HTML' do
    let(:custom_tag) { :marquee }
    let(:custom_text) { "Fanciest accordion heading" }
    let(:custom_class) { "purple" }
    let(:custom_content) { "What a nice accordion!" }

    subject! do
      render_inline(DsfrComponent::AccordionComponent.new(**kwargs)) do |component|
        component.section do |section|
          section.heading_html do
            helper.content_tag(custom_tag, custom_text, class: custom_class)
          end

          custom_content
        end
      end
    end

    specify "renders the custom heading content" do
      expect(rendered_content).to have_tag("h2", with: { class: "govuk-accordion__section-heading" }) do
        with_tag(custom_tag, text: custom_text, with: { class: custom_class })
      end
    end

    specify "renders the custom content" do
      expect(rendered_content).to have_tag("div", with: { class: "govuk-accordion__section-content" }, text: custom_content)
    end

    specify "uses a random string as an identifier to link the heading and content together" do
      button_identifier = html.at_css('span.govuk-accordion__section-button').attribute('id').value
      content_identifier = %(#{button_identifier}-content)

      expect(rendered_content).to have_tag('span', with: { id: button_identifier, 'aria-controls' => content_identifier })
      expect(rendered_content).to have_tag('div', with: { id: content_identifier, 'aria-labelledby' => button_identifier })
    end
  end

  describe 'when no heading text or HTML is supplied' do
    specify "raises an appropriate error" do
      expect {
        render_inline(DsfrComponent::AccordionComponent.new(**kwargs)) do |component|
          component.section(summary_text: "A summary")
        end
      }.to raise_error(ArgumentError, /no heading_text or heading_html/)
    end
  end

  describe 'summaries' do
    specify 'no summary by default' do
      expect(rendered_content).not_to have_tag('.govuk-accordion__section-summary')
    end

    context 'when a summary text is provided' do
      let(:heading_text) { 'a thing' }
      let(:summary_text) { 'some summary content' }
      let(:expected_classes) { %w(govuk-accordion__section-summary govuk-body) }

      subject! do
        render_inline(DsfrComponent::AccordionComponent.new) do |component|
          component.section(heading_text: heading_text, summary_text: summary_text) { 'abc' }
        end
      end

      specify 'the summary is rendered with the right id, class and text' do
        expect(rendered_content).to have_tag('.govuk-accordion__section-header') do
          with_tag('div', with: { id: %(#{heading_text.parameterize}-summary), class: expected_classes }, text: summary_text)
        end
      end
    end

    describe 'overriding the section heading with HTML' do
      let(:custom_tag) { :strong }
      let(:custom_text) { "This is a summary" }
      let(:custom_class) { "special" }
      let(:custom_content) { "What a nice summary!" }
      let(:heading_text) { "some heading" }

      subject! do
        render_inline(DsfrComponent::AccordionComponent.new(**kwargs)) do |component|
          component.section(heading_text: heading_text) do |section|
            section.summary_html do
              helper.content_tag(custom_tag, custom_text, class: custom_class)
            end

            custom_content
          end
        end
      end

      specify "renders the custom summary content" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-accordion__section-header" }) do
          with_tag("div", with: { class: "govuk-accordion__section-summary" }) do
            with_tag(custom_tag, text: custom_text, with: { class: custom_class })
          end
        end
      end

      specify "renders the custom content" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-accordion__section-content" }, text: custom_content)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :section }
    let(:content) { -> { 'some swanky accordion content' } }
    let(:slot_kwargs) { { heading_text: 'A heading_text', summary_text: 'A summary' } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'

    specify 'sections have the correct expanded states' do
      render_inline(DsfrComponent::AccordionComponent.new) do |component|
        component.section(expanded: true, heading_text: 'section 1', html_attributes: { id: 'section_1' }) { 'abc' }
        component.section(heading_text: 'section 2', html_attributes: { id: 'section_2' }) { 'def' }
      end

      expect(rendered_content).to have_tag('div', with: { id: 'section_1', class: %w(govuk-accordion__section govuk-accordion__section--expanded) })
      expect(rendered_content).to have_tag('div', with: { id: 'section_2', class: %w(govuk-accordion__section) })
      expect(rendered_content).to have_tag('span', with: { id: 'section-1', 'aria-expanded' => 'true' })
      expect(rendered_content).to have_tag('span', with: { id: 'section-2', 'aria-expanded' => 'false' })

      expect(rendered_content).not_to have_tag('#section_2', with: { class: 'govuk-accordion__section--expanded' })
    end
  end
end
