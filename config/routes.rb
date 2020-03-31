Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get   'top_pages/home'
  get   'top_pages/contact'
  root  'top_pages#home'
end
