Tripster::Application.routes.draw do

  # this will need to be changed...
  root "users#index"

  resources :users
  resources :trips

  match "/logout", to: "sessions#destroy", as: "logout", via: ["delete", "get"]
  match 'auth/:provider/callback', to: 'sessions#create', via: "get"
  match 'oauth2/authenticate', to: 'feeds/checkins#callback', via: "get"

  match 'auth/failure', to: redirect('/'), via: "get"

  match "/dashboard", to: "trips#dashboard", as: "dashboard", via: "get"

  namespace :feeds do
    get '/photos/connect', to: 'photos#connect',as: "photos_connect"
    get '/photos/callback', to: 'photos#callback'
    get '/checkins/connect', to: 'checkins#connect', as: "checkins_connect"
    get '/checkins/callback', to: 'checkins#callback'
  end
end
