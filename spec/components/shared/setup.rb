shared_context 'setup' do
  let(:component_css_class_matcher) { '.' + component_css_class }
  let(:html) { Nokogiri.parse(rendered_content) }
end
