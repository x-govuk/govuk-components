Rails.application.routes.draw do
  root to: 'demos#show'
  mount Govuk::Components::Engine => "/govuk-components"
  mount Lookbook::Engine, at: "/lookbook"
end
