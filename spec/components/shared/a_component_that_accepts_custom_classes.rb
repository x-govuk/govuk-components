shared_examples 'a component that accepts custom classes' do
  context 'when classes are supplied' do
    before { render_inline(described_class.send(:new, **kwargs.merge(classes: custom_classes))) }

    context 'as a string' do
      let(:custom_classes) { 'yellow-spots black-text' }

      specify 'the classes are present in the rendered output' do
        expect(rendered_content).to have_tag(component_css_class_matcher || component_tag, with: { class: custom_classes.split })
      end
    end

    context 'as an array' do
      let(:custom_classes) { %w(purple-stripes yellow-background) }

      specify 'the classes are present in the rendered output' do
        expect(rendered_content).to have_tag(component_css_class_matcher || component_tag, with: { class: custom_classes })
      end
    end
  end

  context 'when classes are nil' do
    let(:custom_classes) { nil }

    before do
      allow(Rails.logger).to receive(:warn).and_return(true)
      render_inline(described_class.send(:new, **kwargs.merge(classes: custom_classes)))
    end

    specify 'the classes are present in the rendered output' do
      expect(Rails.logger).to have_received(:warn).with(/classes is nil/)
    end
  end
end
