module GovukMarkdown
  class Preprocessor
    attr_reader :output

    def initialize(document)
      @output = document
    end

    def inject_inset_text
      output.gsub!(build_regexp("inset-text")) do
        <<~HTML
          <div class="govuk-inset-text">
            #{Regexp.last_match(1)}
          </div>
        HTML
      end
      self
    end

    def inject_details
      output.gsub!(build_regexp("details")) do
        <<~HTML
          <details class="govuk-details" data-module="govuk-details">
            <summary class="govuk-details__summary">
              <span class="govuk-details__summary-text">
              #{Regexp.last_match(1).split('.', 2).first}
              </span>
            </summary>
            <div class="govuk-details__text">
              #{Regexp.last_match(1).split('.', 2).last}
            </div>
          </details>
        HTML
      end
      self
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
