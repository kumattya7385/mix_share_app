Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root  'top_pages#home'
  get   '/contact', to: 'top_pages#contact'
end
