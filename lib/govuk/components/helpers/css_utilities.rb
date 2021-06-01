module Govuk
  module Components
    module Helpers
      module CssUtilities
        def combine_classes(default_classes, custom_classes)
          converted_custom_classes = case custom_classes
                                     when Array
                                       custom_classes
                                     when String
                                       custom_classes.split
                                     when NilClass
                                       []
                                     else
                                       fail(ArgumentError, "custom classes must be a String, Array or NilClass")
                                     end

          default_classes.concat(converted_custom_classes).uniq
        end
      end
    end
  end
end
