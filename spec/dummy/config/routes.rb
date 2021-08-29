Rails.application.routes.draw do
  mount Govuk::Components::Engine => "/govuk-components"
  mount Lookbook::Engine, at: "/"
end
