# GOV.UK Components

[![Tests](https://github.com/DFE-Digital/govuk-components/workflows/Tests/badge.svg)](https://github.com/DFE-Digital/govuk-components/actions?query=workflow%3ATests)
[![Maintainability](https://api.codeclimate.com/v1/badges/cbcbc140f300b920d833/maintainability)](https://codeclimate.com/github/DFE-Digital/govuk-components/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/cbcbc140f300b920d833/test_coverage)](https://codeclimate.com/github/DFE-Digital/govuk-components/test_coverage)
[![GitHub license](https://img.shields.io/github/license/DFE-Digital/govuk-components)](https://github.com/DFE-Digital/govuk-components/blob/master/LICENSE)
[![GOV.UK Design System Version](https://img.shields.io/badge/GOV.UK%20Design%20System-3.13.0-brightgreen)](https://design-system.service.gov.uk)

This gem provides a suite of reusable components for the [GOV.UK Design System](https://design-system.service.gov.uk/). It is intended to provide a lightweight alternative to the [GOV.UK Publishing Components](https://github.com/alphagov/govuk_publishing_components) library and is built with Github's [ViewComponent](https://github.com/github/view_component) framework.

It aims to implement the functionality from the original Nunjucks macros in a way that will feel more familiar to Rails developers. Blocks are preferred over strings of HTML, beneath the surface each component is just a Ruby object, everything is inheritable and overrideable.

## What's included?

All of the non-form components from the GOV.UK Design System are implmented by this library as ViewComponents. Form components are implemented by the [form builder](https://govuk-form-builder.netlify.app/).

The provided components are:

* [Accordion](https://dfe-digital.github.io/govuk-components/#accordion)
* [Back link](https://dfe-digital.github.io/govuk-components/#back-links)
* [Back to top link](https://dfe-digital.github.io/govuk-components/#back-to-top-link)
* [Breadcrumbs](https://dfe-digital.github.io/govuk-components/#breadcrumbs)
* [Cookie banner](https://dfe-digital.github.io/govuk-components/#cookie-banner)
* [Details](https://dfe-digital.github.io/govuk-components/#details)
* [Footer](https://dfe-digital.github.io/govuk-components/#footer)
* [Header](https://dfe-digital.github.io/govuk-components/#header)
* [Inset text](https://dfe-digital.github.io/govuk-components/#inset-text)
* [Notification banner](https://dfe-digital.github.io/govuk-components/#notification-banner)
* [Panel](https://dfe-digital.github.io/govuk-components/#panel)
* [Phase banner](https://dfe-digital.github.io/govuk-components/#phase-banner)
* [Skip link](https://dfe-digital.github.io/govuk-components/#skip-link)
* [Start button](https://dfe-digital.github.io/govuk-components/#start-button)
* [Summary list](https://dfe-digital.github.io/govuk-components/#summary-list)
* [Tabs](https://dfe-digital.github.io/govuk-components/#tabs)
* [Tags](https://dfe-digital.github.io/govuk-components/#tags)
* [Warning text](https://dfe-digital.github.io/govuk-components/#warning-text)

This library also provides [several link helpers](https://dfe-digital.github.io/govuk-components/#links-and-buttons) that are commonly used in services, include `#govuk_link_to` and `#govuk_button_to`.

## Example use

This library allows components to be rendered with Rails' `render` method or via the provided helpers. Here we'll use the `govuk_accordion` to render an accordion.

```erb
<%= govuk_tabs(title: 'Days of the week') do |component| %>
  <% component.tab(label: 'Monday') do %>
    <p>Monday's child is fair of face</p>
  <% end %>

  <% component.tab(label: 'Tuesday') do %>
    <p>Tuesday's child is full of grace</p>
  <% end %>

  <% component.tab(label: 'Wednesday') do %>
    <p>Wednesday's child is full of woe</p>
  <% end %>
<% end %>

```

Here are the rendered tabs:

![Accordion preview](docs/images/tabs.png)

For examples on usage see the [guide page](https://dfe-digital.github.io/govuk-components/).

## Setup

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

After changing a component or adding a new one:

* add or update the corresponding specs, and check they pass by running `bundle exec rspec`.

* update the examples page by cd-ing into the dummy app `cd spec/dummy` and running the rake task `bin/rake generate_examples_page`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
