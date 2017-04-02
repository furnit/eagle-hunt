require_relative './config.rb'

module GeneralRoutes
  def self.extended(router)
    router.instance_exec do

      root to: 'home#index'

      get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'

      resources :uploaded_files, RC::ajax_server

      # only to create/delete shopping carts and only excepts JSON format
      resources :shopping_carts, RC::ajax_server

      resources :furniture_types, :path => "category" do
        member do
          delete :archive
          patch :recover
        end
      end

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
        registrations: 'users/registrations'
      }


    end
  end
end