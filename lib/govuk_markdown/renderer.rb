module GovukMarkdown
  class Renderer < ::Redcarpet::Render::HTML
    autoload :Mixin, "govuk_markdown/renderer/mixin"

    include ::Redcarpet::Render::SmartyPants
    include Mixin

    def initialize(govuk_options, options = {})
      @headings_start_with = govuk_options[:headings_start_with]
      @strip_front_matter = govuk_options[:strip_front_matter]

      super options
    end
  end
end
