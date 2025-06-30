---
title: Configuration
---

The components gem defaults follow the guidance specified in the GOV.UK
Design System documentation, but every project has different needs. These can
be configured globally, avoiding the need to repeatedly set them each time we
use a component.

We can override the defaults using an initialiser. Create a file
in your project called `config/initializers/govuk_components.rb` and
use the standard Rails configuration syntax:

```language-ruby
Govuk::Components.configure do |conf|
  conf.brand = "swanky-new-design-system" # default is "govuk"
  conf.default_breadcrumbs_collapse_on_mobile = true
  conf.default_header_service_name = "Apply for a Juggling Licence"
  conf.default_phase_banner_text = "Beta"
  conf.default_summary_list_borders = false
  conf.default_tag_colour = "turquoise"
end
```

You can see a full list of the configurable options in
[engine.rb](https://github.com/x-govuk/govuk-components/blob/main/lib/govuk/components/engine.rb).
