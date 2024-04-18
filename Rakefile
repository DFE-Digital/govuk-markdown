require "mkmf"
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Regenerate the example HTML in example/example.html"
task :generate_example do
  require_relative "lib/govuk_markdown"

  markdown = File.read("example/example.md")
  html = GovukMarkdown.render(markdown)

  File.write("example/example.html", ERB.new(File.read("example/example_layout.html.erb")).result(binding))

  case
  when find_executable("xdg-open")     # linux
    sh("xdg-open example/example.html")
  when find_executable("open")         # mac
    sh("open example/example.html")
  else
    puts "View the example in example/example.html"
  end
end

desc "Print the current version of the gem"
task :gem_version do
  require_relative "lib/govuk_markdown/version"

  puts GovukMarkdown::VERSION
end
