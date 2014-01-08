Tripster::Application.routes.draw do

  resources :users
  resources :sessions
  match "/logout", to: "sessions#destroy", as: "logout", via: "delete"
  resources :trips
  root "users#index"

  match "/dashboard", to: "trips#dashboard", as: "dashboard", via: "get"

end
