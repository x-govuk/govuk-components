class VersionFormatter
  attr_accessor :lib, :version, :exact

  def initialize(lib, version, exact)
    self.lib     = lib
    self.version = version
    self.exact   = exact
  end

  def to_a
    [lib, full_version, sub_version].compact
  end

private

  # the 'exact' Rails version as set in the gemspec or
  # RAILS_VERSION environment variable. Returns nil unless
  # an exact version number is required
  #
  # eg (when RAILS_VERSION=6.0.0)
  #   "~> 6.0.0"
  def full_version
    return nil unless exact

    "~> ".concat(version)
  end

  # the sub version which is the first two parts of
  # the three part number
  #
  # eg (when RAILS_VERSION=5.2.3)
  #   ">= 5.2"
  def sub_version
    ">= ".concat(version.split('.').first(2).join('.'))
  end
end
