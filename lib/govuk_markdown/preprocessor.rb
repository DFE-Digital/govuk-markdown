module GovukMarkdown
  class Preprocessor
    attr_reader :document

    def initialize(document)
      @document = document
    end

    def inject_inset_text
      document.gsub(%r(\{inset-text\}(.*)\{/inset-text\})m) do
        <<~HTML
          <div class="govuk-inset-text">
            #{Regexp.last_match(1)}
          </div>
        HTML
      end
    end
  end
end
