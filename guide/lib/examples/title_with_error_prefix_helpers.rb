require 'ostruct'

module Examples
  module TitleWithErrorPrefixHelpers

    def title_containing_error
      <<~TITLE_WITH_ERROR_PREFIX
        = title_with_error_prefix("Personal details", error: true)
      TITLE_WITH_ERROR_PREFIX
    end

    def title_not_containing_error
      <<~TITLE_WITH_ERROR_PREFIX
        = title_with_error_prefix("Personal details", error: false)
      TITLE_WITH_ERROR_PREFIX
    end

    def title_containing_error_and_custom_error_prefix
      <<~TITLE_WITH_ERROR_PREFIX
        = title_with_error_prefix("Manylion personol", error: true, error_prefix: "Gwall: ")
      TITLE_WITH_ERROR_PREFIX
    end

  end
end
