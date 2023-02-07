require_relative "./../lib/govuk_markdown"
require "pry"

def render(content)
  GovukMarkdown.render(content)
end

def expect_equal_ignoring_ws(first, second)
  expect(first.lines.map(&:strip).join("")).to eq(second.lines.map(&:strip).join(""))
end
