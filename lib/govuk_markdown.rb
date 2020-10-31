require "redcarpet"

require "govuk_markdown/version"
require "govuk_markdown/renderer"

module GovukMarkdown
  def self.render(markdown)
    renderer = GovukMarkdown::Renderer.new(with_toc_data: true)
    Redcarpet::Markdown.new(renderer).render(markdown).strip
  end
end
