shared_examples 'a component with a slot that accepts custom classes' do
  let(:custom_class) { 'purple-stripes' }

  subject! do
    render_inline(described_class.send(:new, **kwargs)) do |component|
      component.slot(slot, classes: custom_class, **slot_kwargs, &content)
    end
  end

  specify 'the rendered slot should have the custom class' do
    expect(page).to have_css('.' + custom_class)
  end
end
