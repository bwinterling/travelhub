Tripster::Application.routes.draw do

  # this will need to be changed... 
  root "users#index" 

  resources :users
  resources :trips

  match "/logout", to: "sessions#destroy", as: "logout", via: ["delete", "get"]
  match 'auth/:provider/callback', to: 'sessions#create', via: "get"

  match 'auth/failure', to: redirect('/'), via: "get"

  match "/dashboard", to: "trips#dashboard", as: "dashboard", via: "get"

  namespace :feeds do
    get '/photos/connect', to: 'photos#connect'
    get '/photos/callback', to: 'photos#callback'
  end
end
