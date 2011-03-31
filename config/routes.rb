Rewriter::Application.routes.draw do
  get "user_sessions/new"

  root :to => "home#index"
  
  resources :user_sessions

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  
  resources :shared_urls
  
  match '/new' => "shared_urls#new"
  match '/:id' => "shared_urls#show"

  match "*path", :to => redirect("/")
end
