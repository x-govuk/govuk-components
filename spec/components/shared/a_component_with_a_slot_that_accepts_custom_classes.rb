shared_examples 'a component with a slot that accepts custom classes' do
  let(:custom_class) { 'purple-stripes' }

  subject! do
    render_inline(described_class.send(:new, **kwargs)) do |component|
      component.send(slot, classes: custom_class, **slot_kwargs) { content.call }
    end
  end

  specify 'the rendered slot should have the custom class' do
    expect(rendered_component).to have_tag('*', with: { class: custom_class })
  end
end
