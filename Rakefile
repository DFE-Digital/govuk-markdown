require "bundler/gem_tasks"
task default: :spec

desc "Regenerate the example HTML in example/example.html"
task :generate_example do
  require_relative "lib/govuk_markdown"

  markdown = File.read("example/example.md")
  html = GovukMarkdown.render(markdown)

  File.write("example/example.html", ERB.new(File.read("example/example_layout.html.erb")).result(binding))
  sh "open example/example.html"
end

task :gem_version do
  require_relative "lib/govuk_markdown/version"

  puts GovukMarkdown::VERSION
end
