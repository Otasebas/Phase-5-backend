Rails.application.routes.draw do
  resources :friendrequests, only: [:index]
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
  # delete "/decline/:id", to: "friendrequests#decline"
  delete "/remove/:id", to: "friendrequests#remove"

end
