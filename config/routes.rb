Rewriter::Application.routes.draw do
  root :to => "bookmarks#index"
  
  match '/register' => "users#new",             :as => :register
  match '/login'    => "user_sessions#new",     :as => :login,    :via => :get
  match '/login'    => "user_sessions#create",  :as => :login,    :via => :post
  match '/logout'   => "user_sessions#destroy", :as => :logout
  
  resources :bookmarks
  resources :shared_urls
  
  resources :users do
    resources :bookmarks
  end
  
  match '/shorten'  => "shared_urls#create",    :as => :shorten,  :via => :post
  
  #this should take care of redirecting a short url to its full url
  match '/:id'      => "shared_urls#show"
  
  #redirecting anything not matched to the home url
  match ":controller(/:action/:id/:item_id)", :to => redirect("/")
  match "*path", :to => redirect("/")
end
