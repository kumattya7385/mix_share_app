Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root  'top_pages#home'
  get   '/contact', to: 'top_pages#contact'
  get '/search', to: 'top_pages#search'
  get   '/signup',   to: 'users#new'
  post   '/signup',   to: 'users#create'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new,:create, :edit, :update]
  resources :items
  resources :comments, only: [:create, :destroy]
  resources :testsessions, only: [:create]
end
