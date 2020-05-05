module Govuk
  module Components
    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end
