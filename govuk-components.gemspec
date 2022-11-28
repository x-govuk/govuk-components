$LOAD_PATH.push File.expand_path("lib", __dir__)

require "govuk/components/version"

METADATA = {
  "bug_tracker_uri"   => "https://github.com/DFE-Digital/govuk-components/issues",
  "changelog_uri"     => "https://github.com/DFE-Digital/govuk-components/releases",
  "documentation_uri" => "https://www.rubydoc.info/gems/govuk-components/",
  "homepage_uri"      => "https://github.com/DFE-Digital/govuk-components",
  "source_code_uri"   => "https://github.com/DFE-Digital/govuk-components"
}.freeze

Gem::Specification.new do |spec|
  spec.name        = "govuk-components"
  spec.version     = Govuk::Components::VERSION
  spec.authors     = ["DfE developers"]
  spec.email       = ["peter.yates@digital.education.gov.uk"]
  spec.homepage    = "https://github.com/DFE-Digital/govuk-components"
  spec.summary     = "Lightweight set of reusable GOV.UK Design System components"
  spec.description = "A collection of components intended to ease the building of GOV.UK Design System web applications"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency("html-attributes-utils", "~> 0.9", ">= 0.9.2")
  spec.add_dependency("pagy", "~> 5.10.1")
  spec.add_dependency "view_component", "~> 2.77.0"

  spec.add_development_dependency "deep_merge"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec-html-matchers", "~> 0.9"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop-govuk", "= 4.0.0"
  spec.add_development_dependency "sassc-rails"
  spec.add_development_dependency("simplecov", "~> 0.20")
  spec.add_development_dependency "sqlite3"

  # Required for the guide
  spec.add_development_dependency("htmlbeautifier", "~> 1.4.1")
  spec.add_development_dependency("nanoc", "~> 4.11")
  spec.add_development_dependency("redcarpet", "~> 3.5.1")
  spec.add_development_dependency("rouge", "~> 4.0.0")
  spec.add_development_dependency("rubypants", "~> 0.7.0")
  spec.add_development_dependency("sass")
  spec.add_development_dependency("sassc", "~> 2.4.0")
  spec.add_development_dependency("slim", "~> 4.1.0")
  spec.add_development_dependency("slim_lint", "~> 0.22.0")
  spec.add_development_dependency("webrick", "~> 1.7.0")
end
