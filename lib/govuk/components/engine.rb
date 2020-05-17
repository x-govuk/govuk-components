module Govuk
  module Components
    class Engine < ::Rails::Engine
      isolate_namespace Govuk::Components
    end
  end
end

require Govuk::Components::Engine.root.join(*%w(app helpers govuk_link_helper))
