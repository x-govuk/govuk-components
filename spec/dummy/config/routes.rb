Rails.application.routes.draw do
  root to: "home#index"
  resources :demos, only: [:index]
end
