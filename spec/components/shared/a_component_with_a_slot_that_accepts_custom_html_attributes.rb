shared_examples 'a component with a slot that accepts custom html attributes' do
  let(:custom_attributes) { { lang: "en-GB", style: "background-color: blue;" } }

  subject! do
    render_inline(described_class.send(:new, **kwargs)) do |component|
      component.send("with_#{slot}", html_attributes: custom_attributes, **slot_kwargs) { content.call }
    end
  end

  specify 'the rendered slot should have the HTML attributes' do
    expect(rendered_content).to have_tag(custom_attributes.map { |k, v| %([#{k}='#{v}']) }.join)
  end
end
