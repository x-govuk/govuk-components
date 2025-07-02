---
title: Get started
---

GOV.UK Components are suitable for use with any Rails application that uses the
GOV.UK Design System. They are built using [GitHub's ViewComponent](https://viewcomponent.org/)
framework and are easy to distribute and reuse.

If you’re starting from scratch, the easiest way to hit the ground running is
to use the DfE’s [GOV.UK Rails Template](https://github.com/DFE-Digital/rails-template).

## Installation

Add the following line to your Gemfile and run `bundle install`.

```language-ruby
gem 'govuk-components'
```

When you restart your application you should have access to the full set of
components. You make sure everything's working by creating one in the
`rails console`:

```language-ruby
GovukComponent::PanelComponent.new(title_text: "Hello", text: "world!")
```

If you don't see any error messages, it's properly installed --- you can start
[adding components to your templates](/introduction/using-components).
