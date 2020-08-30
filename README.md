> **Note!** This repository is very new and not yet fully built and documented. Breaking changes can happen at any time. Please check the [components tracker](https://github.com/DFE-Digital/govuk-components/issues/18) to see progress.

# GOV.UK Components

[![Build Status](https://travis-ci.com/DFE-Digital/govuk-components.svg?branch=master)](https://travis-ci.com/DFE-Digital/govuk-components)

This gem provides a suite of reusable components for the [GOV.UK Design System](https://design-system.service.gov.uk/). It is intended to provide a lightweight alternative to the [GOV.UK Publishing Components](https://github.com/alphagov/govuk_publishing_components) library and is built with Github's [ViewComponent](https://github.com/github/view_component) framework.  ViewComponent is [supported natively in Rails 6.1](https://edgeguides.rubyonrails.org/layouts_and_rendering.html#rendering-objects).

## What's included

The gem will include the following components and helpers, [track their progress](https://github.com/DFE-Digital/govuk-components/issues/18):

### Components

* Accordion ✔️
* Back link ✔️
* Breadcrumbs ✔️
* Details ✔️
* Footer ✔️
* Header ✔️
* Inset text ✔️
* Panel ✔️
* Phase banner ✔️
* Start now button ✔️
* Summary list ✔️
* Tabs ✔️
* Tag ✔️
* Warning text ✔️

### Helpers

* `#govuk_link_to` ✔️
* `#govuk_mail_to` ✔️
* `#govuk_button_to` ✔️
* `#govuk_back_to_top_link` ✔️
* Skip link ✔️

## Examples

For examples on usage see the [guide page](https://dfe-digital.github.io/govuk-components/).

## Usage

Add this line to your `config/application.rb`:

```ruby
require "govuk/components"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'govuk-components'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install govuk-components
```

## Contributing

To setup the dummy app:

`cd spec/dummy`
`yarn install`
`bundle install`
`bin/rails db:create`
`bin/rails db:migrate`
`bin/rails s`

After adding a new component update the examples page by cd-ing into the dummy app `cd spec/dummy` and running the rake task `bin/rake generate_examples_page`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
