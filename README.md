# GOV.UK Markdown renderer

This Ruby gem converts Markdown into [GOV.UK Frontend](https://github.com/alphagov/govuk-frontend)-compliant HTML. It's an extension on the default [Redcarpet renderer](https://github.com/vmg/redcarpet).

Don't confuse this gem with [govspeak](https://github.com/alphagov/govspeak), which is a Markdown dialect specifically built for the GOV.UK publishing system (www.gov.uk).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'govuk_markdown'
```

## Usage

```rb
GovukMarkdown.render(markdown)
```

For example:

```rb
GovukMarkdown.render("[A link](/foo)")
```

Will output:

```html
<p class="govuk-body-m">
  <a href="/foo" class="govuk-link">A link</a>
</p>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

You can regenerate the example HTML file from Markdown using `bundle exec rake generate_example`.

## Release a new version

1. Update the version in [lib/govuk_markdown/version.rb](lib/govuk_markdown/version.rb)
2. Run `bundle install`
3. Update [CHANGELOG.md](CHANGELOG.md)
4. Create a pull request

When changes are merged into the `main` branch, a new version will be released using a GitHub action.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DfE-digital/govuk_markdown.
