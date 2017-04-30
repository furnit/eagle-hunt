Rails.application.routes.draw do
  namespace :employee do

    root to: 'home#index'
    
    resources :home, RC::non_restful.merge({:path => ''}) do
      collection do
        post :as
        get  :invalid_path
        get  :ls_furnitures
      end
    end

    [:admins, :fanis, :nagashes, :najars, :kanafs].each do |emply|
      resources emply, only: [:index, :edit, :create] do 
        collection do
          post :update_field, RC::ajax_server.merge(RC::json_request_only)
        end
      end
    end

  end
end