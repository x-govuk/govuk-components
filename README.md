# Govuk::Components
<https://dfe-digital.github.io/govuk-components/>  

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
