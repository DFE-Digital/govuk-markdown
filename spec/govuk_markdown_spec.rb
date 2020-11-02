require "spec_helper"

RSpec.describe GovukMarkdown do
  it "renders tables" do
    markdown =
      <<~MD
        | First name   | Last name    | DOB        |
        | ------------ | ------------ | ---------- |
        | John         | Smith        | 01-04-1970 |
        | Alison       | Brown        | 02-05-1970 |
        | Adam         | Sample       | 03-06-1970 |
      MD

    expected_html = <<~HTML
      <table class='govuk-table'>
        <thead class='govuk-table__head'>
          <tr class='govuk-table__row'>
            <td class='govuk-table__cell'>First name</td>
            <td class='govuk-table__cell'>Last name</td>
            <td class='govuk-table__cell'>DOB</td>
          </tr>
        </thead>
        <tbody class='govuk-table__body'>
          <tr class='govuk-table__row'>
            <td class='govuk-table__cell'>John</td>
            <td class='govuk-table__cell'>Smith</td>
            <td class='govuk-table__cell'>01-04-1970</td>
          </tr>
          <tr class='govuk-table__row'>
            <td class='govuk-table__cell'>Alison</td>
            <td class='govuk-table__cell'>Brown</td>
            <td class='govuk-table__cell'>02-05-1970</td>
          </tr>
          <tr class='govuk-table__row'>
            <td class='govuk-table__cell'>Adam</td>
            <td class='govuk-table__cell'>Sample</td>
            <td class='govuk-table__cell'>03-06-1970</td>
          </tr>
        </tbody>
      </table>
    HTML

    expect_equal_ignoring_ws(render(markdown), expected_html)
  end

  it "renders H1s with ids and GOV.UK classes" do
    expect(render("# My title")).to eq('<h1 id="my-title" class="govuk-heading-xl">My title</h1>')
  end

  it "renders H2s with ids and GOV.UK classes" do
    expect(render("## Top heading")).to eq('<h2 id="top-heading" class="govuk-heading-l">Top heading</h2>')
  end

  it "renders H3s with ids and GOV.UK classes" do
    expect(render("### A heading")).to eq('<h3 id="a-heading" class="govuk-heading-m">A heading</h3>')
  end

  it "renders H4s with ids and GOV.UK classes" do
    expect(render("#### A heading")).to eq('<h4 id="a-heading" class="govuk-heading-s">A heading</h4>')
  end

  it "renders H5s with ids and GOV.UK classes" do
    expect(render("##### A heading")).to eq('<h5 id="a-heading" class="govuk-heading-s">A heading</h5>')
  end

  it "renders H6s with ids and GOV.UK classes" do
    expect(render("###### A heading")).to eq('<h6 id="a-heading" class="govuk-heading-s">A heading</h6>')
  end

  it "renders paragraphs with GOV.UK classes" do
    expect(render("abc")).to eq('<p class="govuk-body-m">abc</p>')
  end

  it "renders unordered lists with GOV.UK classes" do
    input = <<~MARKDOWN
      * abc def
      * xyz
    MARKDOWN
    expected = <<~HTML
      <ul class="govuk-list govuk-list--bullet">
        <li>abc def</li>
      <li>xyz</li>

      </ul>
    HTML
    expect(render(input)).to eq(expected.strip)
  end

  it "renders ordered lists with GOV.UK classes" do
    input = <<~MARKDOWN
      1. abc def
      2. xyz
    MARKDOWN
    expected = <<~HTML
      <ol class="govuk-list govuk-list--number">
        <li>abc def</li>
      <li>xyz</li>

      </ol>
    HTML
    expect(render(input)).to eq(expected.strip)
  end

  it "renders links without titles with GOV.UK classes" do
    expect(render("[GOV.UK homepage](https://www.gov.uk)")).to eq(
      '<p class="govuk-body-m"><a href="https://www.gov.uk" class="govuk-link">GOV.UK homepage</a></p>',
    )
  end

  it "renders links with titles with GOV.UK classes" do
    expect(render('[GOV.UK homepage](https://www.gov.uk "My title")')).to eq(
      '<p class="govuk-body-m"><a href="https://www.gov.uk" class="govuk-link" title="My title">GOV.UK homepage</a></p>',
    )
  end

  it "renders hrules with GOV.UK classes" do
    expect(render("---")).to eq('<hr class="govuk-section-break govuk-section-break--xl govuk-section-break--visible">')
  end

  def render(content)
    GovukMarkdown.render(content)
  end

  def expect_equal_ignoring_ws(first, second)
    expect(first.lines.map(&:strip).join("")).to eq(second.lines.map(&:strip).join(""))
  end
end
