shared_examples 'a component that accepts custom HTML attributes' do
  let(:custom_attributes) { { lang: "en-GB", style: "background-color: blue" } }
  let(:updated_kwargs) { kwargs.deep_merge({ html_attributes: { lang: "en-GB", style: "background-color: blue" } }) }

  subject! { render_inline(described_class.send(:new, **updated_kwargs)) }

  specify 'the custom HTML attributes should be set correctly' do
    expect(rendered_component).to have_tag('*', with: custom_attributes)
  end

  context 'classes' do
    let(:custom_class) { 'red-and-yellow-stripes' }
    let(:updated_kwargs) { kwargs.deep_merge({ html_attributes: { class: Array.wrap(custom_class) } }) }
    let(:actual_classes) { html.at('/*[1]').attr('class').split }

    specify 'the custom class is merged with the default ones' do
      expect(actual_classes).to include(custom_class)
      expect(actual_classes).to include(component_css_class)
    end
  end
end
