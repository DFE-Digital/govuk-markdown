require "spec_helper"

RSpec.describe GovukMarkdown do
  describe "#render" do
    before do
      subject { GovukMarkdown }
    end

    describe "#headings_start_with" do
      context "when headings_start_with l" do
        let(:heading_size) { "l" }

        it "renders an H1 with large text" do
          expect(subject.render("# An H1 title", headings_start_with: heading_size)).to eq('<h1 id="an-h1-title" class="govuk-heading-l">An H1 title</h1>')
        end

        it "renders an H2 with medium text" do
          expect(subject.render("## An H2 title", headings_start_with: heading_size)).to eq('<h2 id="an-h2-title" class="govuk-heading-m">An H2 title</h2>')
        end

        it "renders an H3 with small text" do
          expect(subject.render("### An H3 title", headings_start_with: heading_size)).to eq('<h3 id="an-h3-title" class="govuk-heading-s">An H3 title</h3>')
        end

        it "renders an H4 with small text" do
          expect(subject.render("#### An H4 title", headings_start_with: heading_size)).to eq('<h4 id="an-h4-title" class="govuk-heading-s">An H4 title</h4>')
        end
      end

      context "when headings_start_with is not given" do
        it "renders an H1 with xl text" do
          expect(subject.render("# An H1 title")).to eq('<h1 id="an-h1-title" class="govuk-heading-xl">An H1 title</h1>')
        end

        it "renders an H2 with l text" do
          expect(subject.render("## An H2 title")).to eq('<h2 id="an-h2-title" class="govuk-heading-l">An H2 title</h2>')
        end

        it "renders an H3 with m text" do
          expect(subject.render("### An H3 title")).to eq('<h3 id="an-h3-title" class="govuk-heading-m">An H3 title</h3>')
        end

        it "renders an H4 with s text" do
          expect(subject.render("#### An H4 title")).to eq('<h4 id="an-h4-title" class="govuk-heading-s">An H4 title</h4>')
        end
      end

      context "when an invalid headings_start_with is given" do
        let(:heading_size) { "dog" }

        it "renders an H1 with xl text" do
          expect(subject.render("# An H1 title", headings_start_with: heading_size)).to eq('<h1 id="an-h1-title" class="govuk-heading-xl">An H1 title</h1>')
        end

        it "renders an H2 with l text" do
          expect(subject.render("## An H2 title", headings_start_with: heading_size)).to eq('<h2 id="an-h2-title" class="govuk-heading-l">An H2 title</h2>')
        end

        it "renders an H3 with m text" do
          expect(subject.render("### An H3 title", headings_start_with: heading_size)).to eq('<h3 id="an-h3-title" class="govuk-heading-m">An H3 title</h3>')
        end

        it "renders an H4 with s text" do
          expect(subject.render("#### An H4 title", headings_start_with: heading_size)).to eq('<h4 id="an-h4-title" class="govuk-heading-s">An H4 title</h4>')
        end
      end

      context "as a hash" do
        let(:heading_size) { "m" }

        it "renders an H1 with m text" do
          expect(subject.render("# H1", { headings_start_with: heading_size })).to eq('<h1 id="h1" class="govuk-heading-m">H1</h1>')
        end
      end

      context "when headings_start_with is nil" do
        let(:heading_size) { nil }

        it "renders an H1 with m text" do
          expect(subject.render("# H1", { headings_start_with: heading_size })).to eq('<h1 id="h1" class="govuk-heading-xl">H1</h1>')
        end
      end
    end
  end
end
