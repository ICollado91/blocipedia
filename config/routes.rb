Rails.application.routes.draw do

  get 'charges/new'

  get 'charges/create'
  
  get 'users/show'
  
  post 'users/update'

  devise_for :users
  
  resources :wikis
  
  resources :wikis do 
    resources :collaborators, only: [:new, :create, :destroy]
  end
  resources :charges, only: [:new, :create]
  resources :users, only: [:show, :update]
  
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'

end
