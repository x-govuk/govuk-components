$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "govuk/components/version"

METADATA = {
  "bug_tracker_uri"   => "https://github.com/DFE-Digital/govuk-components/issues",
  "changelog_uri"     => "https://github.com/DFE-Digital/govuk-components/releases",
  "documentation_uri" => "https://www.rubydoc.info/gems/govuk-components/",
  "homepage_uri"      => "https://github.com/DFE-Digital/govuk-components",
  "source_code_uri"   => "https://github.com/DFE-Digital/govuk-components"
}.freeze

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "govuk-components"
  spec.version     = Govuk::Components::VERSION
  spec.authors     = ["DfE developers"]
  spec.email       = ["peter.yates@digital.education.gov.uk"]
  spec.homepage    = "https://github.com/DFE-Digital/govuk-components"
  spec.summary     = "Lightweight set of reusable GOV.UK Design System components"
  spec.description = "A collection of components intended to ease the building of GOV.UK Design System web applications"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activemodel", ">= 6.0"
  spec.add_dependency "railties", ">= 6.0"
  spec.add_dependency "view_component", "~> 2.49.1"

  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec-html-matchers", "~> 0.9"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop-govuk", "= 4.0.0"
  spec.add_development_dependency "sassc-rails"
  spec.add_development_dependency("simplecov", "~> 0.20")
  spec.add_development_dependency "sqlite3"
end
