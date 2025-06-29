require 'govuk_markdown'
require 'slim'

# Use GOV.UK Markdown for embedded markdown
Slim::Embedded.options[:markdown] = {
  fenced_code_blocks: true,
  no_intra_emphasis: true,
  renderer: GovukMarkdown::Renderer.new({}),
  tables: true,
}
