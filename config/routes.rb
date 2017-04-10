require_relative 'routes/config.rb'

Rails.application.routes.draw do
  root to: 'home#index'

  [:category, :furniture].each do |action|
    action = action.to_s
    get "#{action}/:id", to: "home##{action}", as: "home_#{action}"
  end
  
  get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'

  resources :uploaded_files, RC::ajax_server.merge(RC::json_request_only)

  # only to create/delete shopping carts and only excepts JSON format
  resources :shopping_carts, RC::ajax_server.merge(RC::json_request_only)

  resources :profiles
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
    
  devise_scope :user do
    get "users/password/confirm" => "users/passwords#confirm"
    patch "users/password/reset"  => "users/passwords#reset"
  end
end
