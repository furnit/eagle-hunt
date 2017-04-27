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

    [:admins, :fanis, :nagashes, :najars].each do |emply|
      resources emply, only: [:index, :edit, :create] do 
        collection do
          post :update_field
        end
      end
    end

  end
end