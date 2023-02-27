Rails.application.routes.draw do
  resources :members
  resources :friend_groups
  resources :personal_calendars, only: [:index, :create, :destroy]
  resources :users
  
  #user
  post "/signup", to: "users#create"
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/profile", to: "users#me"

  #friends
  post "/request", to: "friendrequests#create"
  patch "/accept/:id", to: "friendrequests#update"
  delete "/remove/:id", to: "friendrequests#remove"

  #groups
  get "/owner", to: "friend_groups#owner"
  get "/membergroups", to: "users#membergroups"
  delete "/leave/:id", to: "members#leave"
  post "/invite", to: "members#invite"
  patch "/acceptinvite/:id", to: "members#acceptinvite"
  delete "/removeinvite/:id", to: "members#declineinvite"

end
