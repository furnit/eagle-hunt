require_relative './config.rb'

module GeneralRoutes
  def self.extended(router)
    router.instance_exec do

      root to: 'home#index'

      get 'category/:id', to: 'home#category', as: 'home_category'
      
      get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'

      resources :uploaded_files, RC::ajax_server

      # only to create/delete shopping carts and only excepts JSON format
      resources :shopping_carts, RC::ajax_server
      

      resources :furnitures do
        member do
          post   :cover, RC::json_request_only
          get    :edit_description
          patch   :update_description
        end
        collection do
          post   :markup, RC::json_request_only
        end
      end

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
  end
end