Rewriter::Application.routes.draw do
  root :to => "home#index"
  
  match '/register'         => "users#new",             :as => :register
  match '/login'            => "user_sessions#new",     :as => :login,            :via => :get
  match '/login'            => "user_sessions#create",  :as => :login,            :via => :post
  match '/logout'           => "user_sessions#destroy", :as => :logout
  match '/change_password'  => "users#update",                                    :via => :put
  match '/change_password'  => "users#change_password", :as => :change_password,  :via => :get
  match '/change_details'   => "users#update",                                    :via => :put
  match '/change_details'   => "users#change_details",  :as => :change_details,   :via => :get
  
  match '/forgot_password'  => 'user_sessions#forgot_password',               :as => :forgot_password, :via => :get
  match '/forgot_password'  => 'user_sessions#forgot_password_lookup_email',  :as => :forgot_password, :via => :post

  put   '/reset_password/:reset_password_code' => 'users#reset_password_submit',:as => :reset_password, :via => :put
  get   '/reset_password/:reset_password_code' => 'users#reset_password',       :as => :reset_password, :via => :get
  
  match '/faq'                  => "about#faq",                 :as => :faq
  match '/termsandconditions'   => "about#termsandconditions",  :as => :termsandconditions
  match '/privacy'              => "about#privacy",             :as => :privacy
  match '/technology'           => "about#technology",          :as => :technology
  
  resources :bookmarks
  resources :shared_urls
  resources :groups
  
  resources :users do
    resources :bookmarks
    resources :groups
  end
  
  namespace :admin do |admin|
    match '/' => 'admin#update', :via => :post
    match '/' => 'admin#index'
    resources :shared_urls
    resources :users
  end
  
  match '/shorten'          => "shared_urls#create",    :as => :shorten,          :via => :post
  
  #this should take care of redirecting a short url to its full url
  match '/:id'              => "shared_urls#show"
  
  #redirecting anything not matched to the home url
  match ":controller(/:action/:id/:item_id)", :to => redirect("/")
  match "*path", :to => redirect("/")
end
