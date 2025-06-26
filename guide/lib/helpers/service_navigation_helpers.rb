module Helpers
  module ServiceNavigationHelpers
    def service_navigation_classes(item)
      if item.path == '/'
        %w[govuk-service-navigation govuk-service-navigation--inverse]
      else
        %w[govuk-service-navigation]
      end
    end
  end
end
