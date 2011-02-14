Rewriter::Application.routes.draw do
  resources :shared_urls
  
  match '/new' => "shared_urls#new"
  match '/:id' => "shared_urls#show"
  
  root :to => "home#index"
  
  match "*path", :to => redirect("/")
end
