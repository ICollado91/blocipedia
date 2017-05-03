Rails.application.routes.draw do
  get 'charges/new'

  get 'charges/create'
  
  get 'users/show'

  devise_for :users
  
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :users, only: [:show]
  
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'

end
