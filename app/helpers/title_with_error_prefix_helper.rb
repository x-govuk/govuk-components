module TitleWithErrorPrefixHelper
  def title_with_error_prefix(title, error:)
    error_prefix = Govuk::Components.config.default_error_prefix
    "#{error_prefix if error}#{title}"
  end
end

ActiveSupport.on_load(:action_view) { include TitleWithErrorPrefixHelper }
