ajax_server = {
  only: [:create, :destroy],
  defaults:    { format: :json }, 
  constraints: { format: :json }
}

Rails.application.routes.draw do
  resources :uploaded_files
  # only to create/delete shopping carts and only excepts JSON format
  resources :shopping_carts, ajax_server
  resources :sitting_sets
  resources :page_items
  resources :furniture_types, :path => "category"
  resources :furnitures
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
  resources :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'
end
