Tripster::Application.routes.draw do

  resources :users
  resources :sessions
  match "/logout", to: "sessions#destroy", as: "logout", via: "delete"
  resources :trips
  root "users#index"
end
