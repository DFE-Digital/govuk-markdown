# GOV.UK Markdown renderer

This Ruby gem converts Markdown into [GOV.UK Frontend](https://github.com/alphagov/govuk-frontend)-compliant HTML. It's an extension on the default [Redcarpet renderer](https://github.com/vmg/redcarpet).

Don't confuse this gem with [govspeak](https://github.com/alphagov/govspeak), which is a Markdown dialect specifically built for the GOV.UK publishing system (www.gov.uk).

Note that this gem supports [GOV.UK Components](https://github.com/DFE-Digital/govuk-components) version 4.0.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'govuk_markdown'
```

## Usage

### Basic usage

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

### Editing the start heading size of headings

By default, H1 headings will be set to XL. You can override the start heading size, for example if you want to start with size L instead.

All subsequent headings i.e. H2, H3, will be sized correctly according to the start heading size. 

Values can be "xl", "l", "m" and "s".

To specify the start heading size for your markdown content, add the below option into your GovukMarkdown.render() method:

```ruby
GovukMarkdown.render(markdown, headings_start_with: "l")
```

### Adding inset text to your markdown

To add [inset text](https://govuk-components.netlify.app/components/inset-text/) to your markdown document, use the following tags:

```markdown
{inset-text}Text to be inset goes here{/inset-text}
```

The renderer also handles multi-line text as well as multiple paragraphs inside the tags:

```markdown
{inset-text}
  Text to be
  inset goes
  here
{/inset-text}
```

### Adding details sections to your markdown

To add the [details component](https://govuk-components.netlify.app/components/details/) to your markdown, use the following tags:

```markdown
{details} Find out about the fox and the dog. Whilst the fox is quick and brown, the dog is lazy. {/details}
```

The first sentence is rendered as the details summary text. The remaining text is rendered as the details text. The renderer handles multiple paragraphs for the details text.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

You can regenerate the example HTML file from Markdown using `bundle exec rake generate_example`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DfE-digital/govuk-markdown.
