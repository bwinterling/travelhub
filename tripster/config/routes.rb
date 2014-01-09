Tripster::Application.routes.draw do

  resources :users
  resources :sessions
  match "/logout", to: "sessions#destroy", as: "logout", via: "delete"
  resources :trips
  root "users#index"

  namespace :feeds do
    get '/photos/connect', to: 'photos#connect'
    get '/photos/callback', to: 'photos#callback'
  end

  match "/dashboard", to: "trips#dashboard", as: "dashboard", via: "get"
  match 'auth/twitter/callback', to: 'sessions#create', via: "get"
  match 'auth/failure', to: redirect('/'), via: "get"

end
