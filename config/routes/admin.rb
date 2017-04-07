require_relative './config.rb'

module AdminRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :admin do

        root to: 'home#index'

        resources :users do
          collection do
            get :states, RC::json_request_only
          end
          member do
            delete  :block
            put     :reset_password
          end
        end

        resources :furniture_types, :path => "category" do
          member do
            delete :archive
            patch  :recover
          end
        end
        
        resources :furnitures do
          member do
            post   :cover, RC::json_request_only
            get    :edit_description
            patch  :update_description
            get    :list_images, RC::json_request_only 
          end
          collection do
            post   :markup, RC::json_request_only
          end
        end
        
        resources :user_types

        resources :home, RC::non_restful.merge({:path => ''}) do
          collection do
            get :dashboard
          end
        end

      end
    end
  end
end