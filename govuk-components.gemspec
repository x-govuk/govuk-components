$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "govuk/components/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "govuk-components"
  spec.version     = Govuk::Components::VERSION
  spec.authors     = ["Peter Yates"]
  spec.email       = ["peter.yates@graphia.co.uk"]
  spec.homepage    = "https://www.github.com/dfe-digital"
  spec.summary     = "Lightweight set of reusable GOV.UK Design System components"
  spec.description = "A collection of components intended to ease the building of GOV.UK Design System web applications"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"
  spec.add_dependency "slim-rails", "~> 3.2"
  spec.add_dependency "view_component", "~> 2.5"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "sassc-rails"
end
