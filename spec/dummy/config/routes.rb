Rails.application.routes.draw do
  mount Govuk::Components::Engine => "/govuk-components"
end
