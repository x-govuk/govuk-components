desc "generate a static example useage page, suitable for publishing on githubpages"
task generate_examples_page: :environment do
  STYLES_PATH = '/html/head/link'.freeze
  JS_PATH = '/html/head/script'.freeze

  html = DemosController.render :show
  css = Rails.application.assets.find_asset('application.css').to_s
  js  = Rails.application.assets.find_asset('application.js').to_s

  doc = Nokogiri::HTML.parse(html)

  styles_link_tag = doc.xpath(STYLES_PATH).first
  js_source_tag = doc.xpath(JS_PATH).first

  inline_styles = Nokogiri::HTML::DocumentFragment.parse("<style>#{css}</style>")
  inline_js = Nokogiri::HTML::DocumentFragment.parse("<script>#{js}</script>")

  styles_link_tag.replace inline_styles
  js_source_tag.replace inline_js

  output_path = Rails.application.root.join('..', '..', 'docs', 'index.html')
  File.write output_path, doc.to_s
end
