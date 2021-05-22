require 'spec_helper'

RSpec.describe(GovukComponent::WarningTextComponent, type: :component, version: 2) do
  include_context 'setup'

  let(:component_css_class) { 'govuk-warning-text' }
  let(:custom_assistive_text) { 'Informative text goes here' }
  let(:kwargs) { { text: text } }
  let(:text) { 'Some fancy warning' }

  subject! { render_inline(GovukComponent::WarningTextComponent.new(**kwargs)) }

  specify 'renders a div element with the right class and text' do
    expect(rendered_component).to have_tag('div', class: component_css_class, text: Regexp.new(text))
  end

  specify 'the icon is present' do
    expect(rendered_component).to have_tag('div', class: component_css_class) do
      with_tag('span', with: { class: 'govuk-warning-text__icon' }, text: GovukComponent::WarningTextComponent::ICON)
    end
  end

  specify 'the default assistive text is included' do
    expect(rendered_component).to have_tag(component_css_class_matcher) do
      with_tag('strong', with: { class: 'govuk-warning-text__text' }) do
        with_tag('span', text: 'Warning', with: { class: 'govuk-warning-text__assistive' })
      end
    end
  end

  context 'when assistive text is overriden' do
    subject! { render_inline(GovukComponent::WarningTextComponent.new(**kwargs.merge(assistive_text: custom_assistive_text))) }

    specify 'the custom assistive text is included' do
      expect(rendered_component).to have_tag('div', class: component_css_class) do
        with_tag('strong', with: { class: 'govuk-warning-text__text' }) do
          with_tag('span', text: custom_assistive_text, with: { class: 'govuk-warning-text__assistive' })
        end
      end
    end
  end

  specify 'the warning text is included' do
    expect(rendered_component).to have_tag(component_css_class_matcher) do
      with_tag('strong', text: Regexp.new(text), with: { class: 'govuk-warning-text__text' })
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
