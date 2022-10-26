require 'spec_helper'

RSpec.describe(DsfrComponent::WarningTextComponent, type: :component) do
  let(:component_css_class) { 'govuk-warning-text' }
  let(:custom_icon_fallback_text) { 'Informative text goes here' }
  let(:kwargs) { { text: text } }
  let(:text) { 'Some fancy warning' }

  subject! { render_inline(DsfrComponent::WarningTextComponent.new(**kwargs)) }

  specify 'renders a div element with the right class and text' do
    expect(rendered_content).to have_tag('div', class: component_css_class, text: Regexp.new(text))
  end

  specify 'the icon is present' do
    expect(rendered_content).to have_tag('div', class: component_css_class) do
      with_tag('span', with: { class: 'govuk-warning-text__icon' }, text: "!")
    end
  end

  specify 'the default assistive text is included' do
    expect(rendered_content).to have_tag(component_css_class_matcher) do
      with_tag('strong', with: { class: 'govuk-warning-text__text' }) do
        with_tag('span', text: 'Warning', with: { class: 'govuk-warning-text__assistive' })
      end
    end
  end

  context 'when assistive text is overriden' do
    subject! { render_inline(DsfrComponent::WarningTextComponent.new(**kwargs.merge(icon_fallback_text: custom_icon_fallback_text))) }

    specify 'the custom assistive text is included' do
      expect(rendered_content).to have_tag('div', class: component_css_class) do
        with_tag('strong', with: { class: 'govuk-warning-text__text' }) do
          with_tag('span', text: custom_icon_fallback_text, with: { class: 'govuk-warning-text__assistive' })
        end
      end
    end
  end

  specify 'the warning text is included' do
    expect(rendered_content).to have_tag(component_css_class_matcher) do
      with_tag('strong', text: Regexp.new(text), with: { class: 'govuk-warning-text__text' })
    end
  end

  context 'overriding the text with a custom HTML block' do
    let(:custom_tag) { "marquee" }
    let(:custom_text) { "Fancy HTML" }
    let(:custom_html) { helper.content_tag(custom_tag, custom_text) }

    subject! do
      render_inline(DsfrComponent::WarningTextComponent.new(**kwargs)) { custom_html }
    end

    specify "renders the custom html" do
      expect(rendered_content).to have_tag(custom_tag, text: custom_text)
    end

    specify "doesn't render any provided text" do
      expect(rendered_content).not_to match(text)
    end
  end

  context "when the icon is overridden" do
    let(:custom_icon) { "?" }
    subject! { render_inline(DsfrComponent::WarningTextComponent.new(**kwargs.merge(icon: custom_icon))) }

    specify "renders the warning text with the custom icon" do
      expect(rendered_content).to have_tag("span", text: custom_icon, with: { class: "govuk-warning-text__icon" })
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
