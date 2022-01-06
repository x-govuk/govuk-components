require "rails/engine"

module Govuk
  module Components
    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

Dir[Govuk::Components::Engine.root.join("app", "helpers", "*.rb")].sort.each { |f| require f }
