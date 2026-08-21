require 'spec_helper'

describe(GovukComponent::FeedbackComponent, type: :component) do
  let(:component_css_class) { 'govuk-feedback' }
  let(:title_text) { 'Help us improve this service' }
  let(:text) { 'Tell us what you really think!' }
  let(:kwargs) { { title_text:, text: } }

  subject! { render_inline(GovukComponent::FeedbackComponent.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'

  specify 'renders a div element with the right classes and text' do
    expect(rendered_content).to have_tag('div', class: component_css_class) do
      with_tag('div', with: { class: 'govuk-grid-row' }) do
        with_tag('div', with: { class: 'govuk-grid-column-two-thirds' }) do
          with_tag('h2', text: title_text)

          with_tag('div', with: { class: 'govuk-feedback__body' }) do
            with_tag('p', text:, with: { class: 'govuk-body' })
          end
        end
      end
    end
  end

  context 'when the heading level is overridden' do
    let(:custom_heading_level) { 5 }
    let(:kwargs) { { title_text:, text:, heading_level: custom_heading_level } }

    specify 'renders a div element with the right classes and text' do
      expect(rendered_content).to have_tag('div', class: component_css_class) do
        with_tag('h5', text: title_text)
      end
    end
  end

  context 'when custom title HTML is passed in' do
    let(:custom_title_class) { 'yellow' }
    let(:custom_title_text) { 'Well, how is it?' }

    subject! do
      render_inline(GovukComponent::FeedbackComponent.new(**kwargs)) do |component|
        component.with_header { %(<h3 class="#{custom_title_class}">#{custom_title_text}</h3>).html_safe }
      end
    end

    specify 'the custom header content is present' do
      expect(rendered_content).to have_tag('div', class: component_css_class) do
        with_tag('div', with: { class: 'govuk-grid-row' }) do
          with_tag('div', with: { class: 'govuk-grid-column-two-thirds' }) do
            with_tag('h3', text: custom_title_text, with: { class: custom_title_class })
          end
        end
      end
    end
  end

  context 'when custom body HTML is passed in' do
    let(:custom_body_class) { 'emboss' }
    let(:custom_body_text) { 'Tell us what you think about the service' }

    subject! do
      render_inline(GovukComponent::FeedbackComponent.new(**kwargs)) do |component|
        component.with_body { %(<strong class="#{custom_body_class}">#{custom_body_text}</strong>).html_safe }
      end
    end

    specify 'the custom header content is present' do
      expect(rendered_content).to have_tag('div', class: component_css_class) do
        with_tag('div', with: { class: 'govuk-feedback__body' }) do
          with_tag('strong', text: custom_body_text, with: { class: 'emboss' })
        end
      end
    end
  end

  context 'when no title_text or header is provided' do
    expected_message = 'title_text or header is missing'

    specify "argument error is raised with: #{expected_message}" do
      expect {
        render_inline(GovukComponent::FeedbackComponent.new(text: 'a'))
      }.to raise_error(ArgumentError, expected_message)
    end
  end

  context 'when no text or body is provided' do
    expected_message = 'text or body is missing'

    specify "argument error is raised with: #{expected_message}" do
      expect {
        render_inline(GovukComponent::FeedbackComponent.new(title_text: 'a'))
      }.to raise_error(ArgumentError, expected_message)
    end
  end
end
