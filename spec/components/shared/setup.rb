shared_context 'setup' do
  let(:component_css_class_matcher) do
    if component_css_class.blank?
      nil
    else
      '.' + component_css_class
    end
  end
  let(:html) { Nokogiri.parse(rendered_content) }
end
