Rails.application.routes.draw do
  resources :event_users
  resources :calendar_dates
  resources :members
  resources :friend_groups
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

  #calendar
  post "/createpersonalevent", to: "calendar_dates#createpersonal"
  get "/personaldates", to: "calendar_dates#personal"
  delete "/personaldates/:id", to: "calendar_dates#destroypersonal"

  get "/groupdates", to: "calendar_dates#groups"

  post "/createevent", to: "calendar_dates#event"
  get "/events/:id", to: "calendar_dates#grab"
  patch "/saveevent/:id", to: "calendar_dates#plan"
  patch "/sendinvite/:id", to: "calendar_dates#sendinvites"

  get "/events", to: "calendar_dates#user_events"

  get "/anyevent/:id", to: "calendar_dates#user_event"

end
