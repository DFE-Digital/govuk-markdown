require "active_support/all"
require "redcarpet"

require_relative "./govuk_markdown/version"
require_relative "./govuk_markdown/renderer"

module GovukMarkdown
  def self.render(markdown, govuk_options = {})
    renderer = GovukMarkdown::Renderer.new(govuk_options, { with_toc_data: true, link_attributes: { class: "govuk-link" } })
    Redcarpet::Markdown.new(renderer, tables: true, no_intra_emphasis: true).render(markdown).strip
  end
end
