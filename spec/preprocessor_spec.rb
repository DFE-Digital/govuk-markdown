require "spec_helper"

RSpec.describe "GovukMarkdown with textual component extensions" do
  let(:a_line_of_text) { "My custom text. Some extra details. And a few more." }
  let(:output_summary) { "My custom text" }
  let(:output_details_text) { "Some extra details. And a few more." }
  let(:additional_details_text) { "Additional details. Don't you just love more details." }
  let(:some_lines_of_text) do
    <<~TEXT
      The quick
      brown fox
      jumped over the
      lazy dog
    TEXT
  end

  describe "inset text" do
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

  describe "details" do
    context "when there is a details section" do
      let(:input) do
        <<~MD
          an unrelated paragraph

          {details}#{a_line_of_text}{/details}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <details class="govuk-details" data-module="govuk-details">
            <summary class="govuk-details__summary">
              <span class="govuk-details__summary-text">
                #{output_summary}
              </span>
            </summary>
            <div class="govuk-details__text">
              #{output_details_text}
            </div>
          </details>

          <p class="govuk-body-m">an unrelated paragraph</p>
        HTML
      end

      it "renders the details section" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end

      context "and the split is on a question mark" do
        let(:details_with_question) { "What about this fox and dog? Good question. In the end they became cute friends." }

        let(:input) do
          <<~MD
            an unrelated paragraph

            {details}#{details_with_question}{/details}

            an unrelated paragraph
          MD
        end

        let(:expected_output) do
          <<~HTML
            <p class="govuk-body-m">an unrelated paragraph</p>

            <details class="govuk-details" data-module="govuk-details">
              <summary class="govuk-details__summary">
                <span class="govuk-details__summary-text">
                  What about this fox and dog?
                </span>
              </summary>
              <div class="govuk-details__text">
                Good question. In the end they became cute friends.
              </div>
            </details>

            <p class="govuk-body-m">an unrelated paragraph</p>
          HTML
        end

        it "renders the details section" do
          expect_equal_ignoring_ws(render(input), expected_output)
        end
      end

      context "and the text contains a question mark that comes after a fullstop" do
        let(:details) { "Find out more. Will the fox and the dog remain friends? Or are they just too different?" }

        let(:input) do
          <<~MD
            an unrelated paragraph

            {details}#{details}{/details}

            an unrelated paragraph
          MD
        end

        let(:expected_output) do
          <<~HTML
            <p class="govuk-body-m">an unrelated paragraph</p>

            <details class="govuk-details" data-module="govuk-details">
              <summary class="govuk-details__summary">
                <span class="govuk-details__summary-text">
                  Find out more
                </span>
              </summary>
              <div class="govuk-details__text">
                Will the fox and the dog remain friends? Or are they just too different?
              </div>
            </details>

            <p class="govuk-body-m">an unrelated paragraph</p>
          HTML
        end

        it "renders the details section" do
          expect_equal_ignoring_ws(render(input), expected_output)
        end
      end
    end

    context "multiple details sections" do
      let(:input) do
        <<~MD
          an unrelated paragraph

          {details}#{a_line_of_text}{/details}

          {details}#{additional_details_text}{/details}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <details class="govuk-details" data-module="govuk-details">
            <summary class="govuk-details__summary">
              <span class="govuk-details__summary-text">
                #{output_summary}
              </span>
            </summary>
            <div class="govuk-details__text">
              #{output_details_text}
            </div>
          </details>

          <details class="govuk-details" data-module="govuk-details">
            <summary class="govuk-details__summary">
              <span class="govuk-details__summary-text">
                Additional details
              </span>
            </summary>
            <div class="govuk-details__text">
              Don't you just love more details.
            </div>
          </details>

          <p class="govuk-body-m">an unrelated paragraph</p>
        HTML
      end

      it "renders multiple details sections" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end
  end

  describe "multiple preprocessing steps" do
    context "inset text and details" do
      let(:input) do
        <<~MD
          an unrelated paragraph

          {details}#{a_line_of_text}{/details}

          {inset-text}#{a_line_of_text}{/inset-text}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <details class="govuk-details" data-module="govuk-details">
            <summary class="govuk-details__summary">
              <span class="govuk-details__summary-text">
                #{output_summary}
              </span>
            </summary>
            <div class="govuk-details__text">
              #{output_details_text}
            </div>
          </details>

          <div class="govuk-inset-text">
            #{a_line_of_text}
          </div>

          <p class="govuk-body-m">an unrelated paragraph</p>
        HTML
      end

      it "renders correctly" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end
  end
end
