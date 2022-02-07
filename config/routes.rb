Rails.application.routes.draw do
  root to: 'customers#index'
  resources :orders
  resources :customers do
    resources :orders
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
