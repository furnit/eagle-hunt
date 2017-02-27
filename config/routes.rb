Rails.application.routes.draw do
  resources :transfer_costs
  resources :payments
  resources :accountings
  resources :orders
  resources :order_statuses
  resources :parche_designs
  resources :parche_colours
  resources :kande_colours
  resources :cost_factors
  resources :avail_workshops
  resources :workshops
  resources :workshop_types
  resources :furnitaures
  resources :furnitaure_wages
  resources :furniture_details
  resources :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
