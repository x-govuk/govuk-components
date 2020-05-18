module Govuk
  module Components
    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

Dir[Govuk::Components::Engine.root.join(*%w(app helpers *.rb))].each { |f| require f }
