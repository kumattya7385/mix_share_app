Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root  'top_pages#home'
  get   '/contact', to: 'top_pages#contact'
  get   '/signup',   to: 'users#new'
  post   '/signup',   to: 'users#create'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'items',  to:'items#index'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new,:create, :edit, :update]
  resources :microposts,  only: [:create,:destroy]
end
