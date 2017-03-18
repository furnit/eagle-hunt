ajax_server = {
  only: [:create, :destroy],
  defaults:    { format: :json }, 
  constraints: { format: :json }
}

Rails.application.routes.draw do
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
  resources :furnitures
  resources :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'
end
