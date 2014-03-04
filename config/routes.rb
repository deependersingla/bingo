Bingo::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
end