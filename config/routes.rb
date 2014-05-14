Bingo::Application.routes.draw do
  root :to => "game#play"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
end