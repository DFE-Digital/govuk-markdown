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

          {inset-text}#{some_lines_of_text}{/inset-text}

          an unrelated paragraph
        MD
      end

      let(:expected_output) do
        <<~HTML
          <p class="govuk-body-m">an unrelated paragraph</p>

          <div class="govuk-inset-text">
            <p class="govuk-body-m">#{some_lines_of_text}</p>
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

          {inset-text}#{some_lines_of_text}{/inset-text}

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
            <p class="govuk-body-m">
              #{some_lines_of_text}
            </p>
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
    context "when there is one details section" do
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

      context "and there are multiple paragraphs inside" do
        let(:summary_with_multiple_paragraphs) do
          <<~CONTENT
            The summary.

            First paragraph

            Second paragraph
          CONTENT
        end

        let(:input) do
          <<~MD
            an unrelated paragraph

            {details}
              #{summary_with_multiple_paragraphs}
            {/details}

            an unrelated paragraph
          MD
        end

        let(:expected_output) do
          <<~HTML
            <p class="govuk-body-m">an unrelated paragraph</p>

            <details class="govuk-details" data-module="govuk-details">
              <summary class="govuk-details__summary">
                <span class="govuk-details__summary-text">
                  The summary
                </span>
              </summary>
              <div class="govuk-details__text">
                <p class="govuk-body-m">First paragraph</p>

                <p class="govuk-body-m">Second paragraph</p>
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

  describe "strip front matter" do
    let(:input) do
      <<~MD
        ---
        title: Hi
        tags: hello, world
        ---

        Waffle waffle waffle waffle.

        Waffle waffle waffle waffle.
      MD
    end

    let(:actual_output) { render(input, { strip_front_matter: }) }

    context "when front matter is stripped" do
      let(:strip_front_matter) { true }

      let(:expected_output) do
        <<~EXPECTED.strip
          <p class="govuk-body-m">Waffle waffle waffle waffle.</p>
          <p class="govuk-body-m">Waffle waffle waffle waffle.</p>
        EXPECTED
      end

      it "renders no front matter" do
        expect(actual_output).not_to include("title")
      end

      it "renders without front matter" do
        expect(actual_output).to eql(expected_output)
      end
    end

    context "when front matter is not stripped" do
      let(:strip_front_matter) { false }

      let(:expected_output) do
        <<~EXPECTED.strip
          <p class="govuk-body-m">Waffle waffle waffle waffle.</p>
          <p class="govuk-body-m">Waffle waffle waffle waffle.</p>
        EXPECTED
      end

      it "renders the front matter" do
        expect(actual_output).to include(%(<hr class="govuk-section-break govuk-section-break--xl govuk-section-break--visible">))
        expect(actual_output).to include(%(<p class="govuk-body-m">title: Hi</p>))
        expect(actual_output).to include(%(<h2 id="tags-hello-world" class="govuk-heading-l">tags: hello, world</h2>))
      end

      it "renders the content too" do
        expect(actual_output).to include(expected_output)
      end
    end
  end

  describe "multiple preprocessing steps" do
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

    context "inset text and details" do
      let(:input) do
        <<~MD
          an unrelated paragraph

          {details}#{a_line_of_text}{/details}

          {inset-text}#{a_line_of_text}{/inset-text}

          an unrelated paragraph
        MD
      end

      it "renders correctly" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end

    context "when the input string is frozen" do
      let(:input) do
        <<~MD.freeze
          an unrelated paragraph

          {details}#{a_line_of_text}{/details}

          {inset-text}#{a_line_of_text}{/inset-text}

          an unrelated paragraph
        MD
      end

      it "renders correctly" do
        expect_equal_ignoring_ws(render(input), expected_output)
      end
    end
  end
end
