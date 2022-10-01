require "spec_helper"

RSpec.describe "GovukMarkdown with textual component extensions" do
  it "renders inset text within a GOV.UK classes" do
    sample_sentence = "Lorem ipsum dolor sit amet"
    sample_lines = <<~LINES
      Lorem
      ipsum
      dolor
      sit
      amet
    LINES

    examples = {
      sample_sentence => "{inset-text}#{sample_sentence}{/inset-text}",
      sample_lines => <<~MULTILINE_EXAMPLE,
        {inset-text}
          #{sample_lines}
        {/inset-text}
      MULTILINE_EXAMPLE
    }

    examples.each do |text, markdown|
      expected_html = <<~HTML
        <p class="govuk-body-m">an unrelated paragraph</p>

        <div class="govuk-inset-text">
          #{text}
        </div>

        <p class="govuk-body-m">an unrelated paragraph</p>
      HTML

      markdown = <<~MD
        an unrelated paragraph

        #{markdown}

        an unrelated paragraph
      MD

      expect_equal_ignoring_ws(render(markdown), expected_html)
    end
  end
end
