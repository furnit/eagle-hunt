Rails.application.routes.draw do
  namespace :admin do

    root to: 'home#index'
    
    resources :contacts
    
    resources :uploaded_files, RC::ajax_server.merge(RC::json_request_only).merge({only: [:create, :destroy]})

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
    
    resources :user_types

    resources :home, RC::non_restful.merge({:path => ''}) do
      collection do
        get :dashboard
      end
    end
    
    resources :systems, RC::non_restful do
    end
    
    # <furniture>
    namespace :furniture do 
      # <fabric>
      namespace :fabric do
        resources :brands
        resources :cushions
        resources :qualities
      
        resources :fabrics do
          member do
            delete :archive
            patch  :recover
            get    :list_images, RC::json_request_only 
          end
        end
      end
      # </fabric>
      
      resources :furnitures do
        member do
          post   :cover, RC::json_request_only
          get    :edit_description, RC::ajax_server
          patch  :update_description
          get    :list_images, RC::json_request_only 
          get    :ls_intel, RC::ajax_server
          post   :confirm, RC::ajax_server.merge(RC::json_request_only)
          get    :ls_price_details, RC::ajax_server
          put    :toggle_available
        end
        collection do
          post   :markup, RC::json_request_only
        end
      end
      
      resources :sections, except: [:show] do
        member do
          get :list_images, RC::json_request_only
        end
      end
      
      [:foam_types, :specs, :sets, :pieces].each do |rsrc|
        resources rsrc, except: [:show]
      end
      
      resources :types, :path => "category" do
        member do
          delete :archive
          patch  :recover
          get    :list_images, RC::json_request_only 
        end
      end
      
      resources :fabric_colors, except: [:show, :create] do
        collection do 
          post :compute
        end
      end
      
      resources :wood_types
      
      resources :paint_color_qualities
      
      resources :paint_color_brands
  
      resources :paint_colors   
    end
    # </furniture>
    
    # <workshop>
    namespace :workshop do
      resources :workshops do
        member do
          put :toggle_cease
        end
      end
    end 
    # </workshop>
    
    # <pricing>
    namespace :pricing do
      resources :foams
      resources :woods
      resources :consts
      resources :kalafs
      resources :fabrics
      resources :paint_colors
      resources :paint_astar_rouyes
      resources :computes, RC::non_restful do
        post :index, RC::ajax_server.merge(RC::json_request_only)
      end
      resources :transits do
        member do
          get :ls_transit
        end
      end
    end
    # </pricing>
    
    # <selling>
    namespace :selling do
      namespace :config do
        resources :profits
        resources :prices
        resources :piece_prices
        resources :days_to_completes
      end
    end
    # </selling>
    
  end
end