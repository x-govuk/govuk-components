module GovukComponent
  module Traits
    module CustomClasses

      def classes
        default_classes.concat(Array.wrap(@classes))
      end

      def default_classes
        Rails.logger.warn(%(#default_classes hasn't been defined in #{self.class}))

        []
      end

    private

      def parse_classes(classes)
        return [] unless classes.present?

        case classes
        when Array
          classes
        when String
          classes.split
        end
      end
    end
  end
end
