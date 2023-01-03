module GovukMarkdown
  class Preprocessor
    attr_reader :document

    def initialize(document)
      @document = document
    end

    def inject_inset_text
      document.gsub(build_regexp("inset-text")) do
        <<~HTML
          <div class="govuk-inset-text">
            #{Regexp.last_match(1)}
          </div>
        HTML
      end
    end

  private

    def build_regexp(tag_name, pre_tag: "{", post_tag: "}", closing: "/")
      start_tag = pre_tag + tag_name + post_tag
      end_tag = pre_tag + closing + tag_name + post_tag
      pattern = [Regexp.quote(start_tag), "(.*?)", Regexp.quote(end_tag)].join

      Regexp.compile(pattern, Regexp::EXTENDED | Regexp::MULTILINE)
    end
  end
end
