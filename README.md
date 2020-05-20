# [Work in progress] Govuk::Components
<https://dfe-digital.github.io/govuk-components/>  

> Note! This repository is very new and not yet fully built and documented. Breaking changes can happen at any time. Please check the [components tracker](https://github.com/DFE-Digital/govuk-components/issues/18) to see progress.

Short description and motivation.

## Usage
How to use my plugin.

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
To setup the dummy app  
`cd spec/dummy`  
`yarn install`  
`bundle install`  
`bin/rails db:create`  
`bin/rails db:migrate`  
`bin/rails s`  

After adding a new component update the examples page by cd-ing into the dummy
app `cd spec/dummy` and running the rake task `bin/rake generate_examples_page`.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
