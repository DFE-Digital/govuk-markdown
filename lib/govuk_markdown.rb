require "active_support/all"
require "redcarpet"

require_relative "./govuk_markdown/version"
require_relative "./govuk_markdown/renderer"

module GovukMarkdown
  def self.render(markdown)
    renderer = GovukMarkdown::Renderer.new(with_toc_data: true)
    Redcarpet::Markdown.new(renderer, tables: true, no_intra_emphasis: true).render(markdown).strip
  end
end
