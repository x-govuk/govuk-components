$LOAD_PATH.push File.expand_path("lib", __dir__)

require "govuk/components/version"

METADATA = {
  "bug_tracker_uri"   => "https://github.com/x-govuk/govuk-components/issues",
  "changelog_uri"     => "https://github.com/x-govuk/govuk-components/releases",
  "documentation_uri" => "https://www.rubydoc.info/gems/govuk-components/",
  "homepage_uri"      => "https://github.com/x-govuk/govuk-components",
  "source_code_uri"   => "https://github.com/x-govuk/govuk-components"
}.freeze

Gem::Specification.new do |spec|
  spec.name        = "govuk-components"
  spec.version     = Govuk::Components::VERSION
  spec.authors     = ["DfE developers"]
  spec.email       = ["peter.yates@digital.education.gov.uk"]
  spec.homepage    = "https://github.com/x-govuk/govuk-components"
  spec.summary     = "GOV.UK Components for Ruby on Rails"
  spec.description = "This library provides view components for the GOV.UK Design System. It makes creating services more familiar for Ruby on Rails developers."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency("html-attributes-utils", "~> 1.0.0", ">= 1.0.0")
  spec.add_dependency("pagy", ">= 6", "< 8")
  spec.add_dependency("view_component", ">= 3.9", "< 3.12")

  spec.add_development_dependency "deep_merge"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec-html-matchers", "~> 0.9"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop-govuk", "= 4.16.1"
  spec.add_development_dependency "sassc-rails"
  spec.add_development_dependency("simplecov", "~> 0.20")
  spec.add_development_dependency "sqlite3"

  # Required for the guide
  spec.add_development_dependency("htmlbeautifier", "~> 1.4.1")
  spec.add_development_dependency("nanoc", "~> 4.11")
  spec.add_development_dependency("redcarpet", "~> 3.6.0")
  spec.add_development_dependency("rouge", "~> 4.2.0")
  spec.add_development_dependency("rubypants", "~> 0.7.0")
  spec.add_development_dependency("sass")
  spec.add_development_dependency("sassc", "~> 2.4.0")
  spec.add_development_dependency("slim", "~> 5.2.0")
  spec.add_development_dependency("slim_lint", "~> 0.27.0")
  spec.add_development_dependency("webrick", "~> 1.8.1")
end
