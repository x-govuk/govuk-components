shared_examples 'a component with a slot that accepts custom html attributes' do
  let(:custom_attributes) { { lang: "en-GB", style: "background-color: blue;" } }

  subject! do
    render_inline(described_class.send(:new, **kwargs)) do |component|
      component.send(slot, html_attributes: custom_attributes, **slot_kwargs, &content)
    end
  end

  specify 'the rendered slot should have the HTML attributes' do
    expect(page).to have_css(custom_attributes.map { |k, v| %([#{k}='#{v}']) }.join)
  end
end
