json_request_only = {
  defaults:    { format: :json }, 
  constraints: { format: :json }
}

ajax_server = {
  constraints: lambda { |request| request.xhr? },
  only: [:create, :destroy]
}.merge(json_request_only)

Rails.application.routes.draw do
  
  root to: 'home#index'
  
  get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'
  
  resources :uploaded_files, ajax_server
  
  # only to create/delete shopping carts and only excepts JSON format
  resources :shopping_carts, ajax_server
  
  resources :furniture_types, :path => "category" do
    member do 
      delete :delete_image
      delete :archive
      patch :recover
    end
  end
  resources :furnitures do
    member do 
      delete :delete_image
    end
  end
  resources :profiles
  devise_for :users
end
