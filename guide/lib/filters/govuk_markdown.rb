require 'govuk_markdown'

Nanoc::Filter.define(:govuk_markdown) do |content, params|
  renderer = GovukMarkdown::Renderer.new(params)
  markdown = Redcarpet::Markdown.new(renderer,
                                     fenced_code_blocks: true,
                                     no_intra_emphasis: true,
                                     tables: true)
  markdown.render(content).strip
end
