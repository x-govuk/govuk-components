shared_examples 'a component that accepts custom classes' do
  subject! { render_inline(component_class.send(:new, **kwargs.merge(classes: custom_classes))) }

  context 'when classes are supplied as a string' do
    let(:custom_classes) { 'purple-stripes' }

    context 'the custom classes should be set' do
      specify { expect(page).to have_css(".#{custom_classes}") }
    end
  end

  context 'when classes are supplied as an array' do
    let(:custom_classes) { %w(purple-stripes yellow-background) }

    context 'the custom classes should be set' do
      specify { expect(page).to have_css(".#{custom_classes.join('.')}") }
    end
  end
end
