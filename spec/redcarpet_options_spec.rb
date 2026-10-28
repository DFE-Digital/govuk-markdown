require "spec_helper"

describe "redcarpett_options" do
  subject { GovukMarkdown }

  context "when codeblocks are enabled" do
    let(:govuk_options) { { fenced_code_blocks: true } }

    it "renders code blocks" do
      expect_equal_ignoring_ws(subject.render(<<~INPUT, {}, govuk_options), <<~EXPECTED_OUTPUT)
        The quick brown fox

        ```json
        { "jumped": "over" }
        ```

        the lazy dog.
      INPUT
        <p class="govuk-body-m">The quick brown fox</p>

        <pre>
          <code class="json">
           { &quot;jumped&quot;: &quot;over&quot; }
          </code>
        </pre>

        <p class="govuk-body-m">the lazy dog.</p>
      EXPECTED_OUTPUT
    end
  end
end
