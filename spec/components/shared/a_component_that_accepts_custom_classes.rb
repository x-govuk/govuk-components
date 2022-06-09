shared_examples 'a component that accepts custom classes' do
  before { render_inline(described_class.send(:new, **kwargs.merge(classes: custom_classes))) }

  context 'when classes are supplied as a string' do
    let(:custom_classes) { 'yellow-spots black-text' }

    specify 'the classes are present in the rendered output' do
      expect(rendered_content).to have_tag(component_css_class_matcher, with: { class: custom_classes.split })
    end
  end

  context 'when classes are supplied as an array' do
    let(:custom_classes) { %w(purple-stripes yellow-background) }

    specify 'the classes are present in the rendered output' do
      expect(rendered_content).to have_tag(component_css_class_matcher, with: { class: custom_classes })
    end
  end
end
