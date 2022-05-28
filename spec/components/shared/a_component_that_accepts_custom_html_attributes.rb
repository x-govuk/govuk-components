shared_examples 'a component that accepts custom HTML attributes' do
  let(:custom_attributes) { { lang: "en-GB", style: "background-color: blue" } }
  let(:updated_kwargs) { kwargs.deep_merge({ html_attributes: { lang: "en-GB", style: "background-color: blue" } }) }

  subject! { render_inline(described_class.send(:new, **updated_kwargs)) }

  specify 'the custom HTML attributes should be set correctly' do
    expect(rendered_component).to have_tag('*', with: custom_attributes)
  end
end
