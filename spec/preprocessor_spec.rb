require "spec_helper"

RSpec.describe "GovukMarkdown with textual component extensions" do
  describe "inset text" do
    let(:a_line_of_text) { "my custom text" }

    let(:some_lines_of_text) do
      <<~TEXT
        The quick
        brown fox
        jumped over the
        lazy dog
      TEXT
    end

    context "when there is an inline piece of inset text" do
      let(:input) do
        <<~MD
          an unrelated paragraph

          {inset-text}#{a_line_of_text}{/inset-text}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <div class="govuk-inset-text">
            #{a_line_of_text}
          </div>

          <p class="govuk-body-m">an unrelated paragraph</p>
        HTML
      end

      it "renders the line of inset text" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end

    context "when there is a block of inset text" do
      let(:some_lines_of_text) do
        <<~TEXT
          The quick
          brown fox
          jumped over the
          lazy dog
        TEXT
      end

      let(:input) do
        <<~MD
          an unrelated paragraph

          {inset-text}
            #{some_lines_of_text}
          {/inset-text}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <div class="govuk-inset-text">
            #{some_lines_of_text}
          </div>

          <p class="govuk-body-m">an unrelated paragraph</p>
        HTML
      end

      it "renders the block of inset text" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end

    context "when there are multiple blocks of inset text" do
      let(:input) do
        <<~MD
          an unrelated paragraph

          {inset-text}#{a_line_of_text}{/inset-text}

          an unrelated paragraph

          {inset-text}
            #{some_lines_of_text}
          {/inset-text}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <div class="govuk-inset-text">
            #{a_line_of_text}
          </div>

          <p class="govuk-body-m">an unrelated paragraph</p>

          <div class="govuk-inset-text">
            #{some_lines_of_text}
          </div>

          <p class="govuk-body-m">an unrelated paragraph</p>
        HTML
      end

      it "renders both pieces of inset text separately" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end
  end
end
