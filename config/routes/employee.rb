Rails.application.routes.draw do
  namespace :employee do

    root to: 'home#index'
    
    resources :home, RC::non_restful.merge({:path => ''}) do
      collection do
        post :as
        get  :ls_furnitures
      end
    end

    [:admins, :fanis, :nagashes].each do |emply|
      resources emply, only: [:index, :edit, :create]
    end

  end
end