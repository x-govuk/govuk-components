shared_examples 'a component that accepts custom HTML attributes' do
  let(:custom_attributes) { { lang: "en-GB", style: "background-color: blue" } }
  let(:updated_kwargs) { kwargs.deep_merge({ html_attributes: { lang: "en-GB", style: "background-color: blue" } }) }

  subject! { render_inline(described_class.send(:new, **updated_kwargs)) }

  specify 'the custom HTML attributes should be set correctly' do
    expect(rendered_content).to have_tag('*', with: custom_attributes)
  end

  context 'classes' do
    let(:custom_class) { 'red-and-yellow-stripes' }
    let(:updated_kwargs) { kwargs.deep_merge({ html_attributes: { class: Array.wrap(custom_class) } }) }

    specify 'the custom class is merged with the default ones' do
      expect(rendered_content).to have_tag('*', with: { class: [custom_class, component_css_class] })
    end
  end
end
