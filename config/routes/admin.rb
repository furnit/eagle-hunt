Rails.application.routes.draw do
  namespace :admin do

    root to: 'home#index'
    
    resources :uploaded_files, RC::ajax_server.merge(RC::json_request_only).merge({only: [:create, :update]})

    resources :users do
      collection do
        get :states, RC::json_request_only
        post :send_two_step_auth_token, RC::ajax_server
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
        get    :list_images, RC::json_request_only 
      end
    end
    
    resources :furnitures do
      member do
        post   :cover, RC::json_request_only
        get    :edit_description, RC::ajax_server
        patch  :update_description
        get    :list_images, RC::json_request_only 
        get    :ls_intel, RC::ajax_server
        post   :confirm, RC::ajax_server.merge(RC::json_request_only)
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
    
    resources :furniture_sections, except: [:show] do
      member do
        get :list_images, RC::json_request_only
      end
    end
    
    [:furniture_stuff_abrs, :furniture_specs].each do |rsrc|
      resources rsrc, except: [:show]
    end
    
    resources :systems, RC::non_restful do
    end
    
    resources :fabric_types
    
  end
end