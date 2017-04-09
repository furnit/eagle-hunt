require_relative './config.rb'

module EmployeeRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :employee do

        root to: 'home#index'
        
        resources :home, RC::non_restful.merge({:path => ''}) do
          collection do
            post :as
            get  :ls_furnitures
          end
        end

        [:admins, :fanis].each do |emply|
          resources emply, only: [:index, :new, :create]
        end

      end
    end
  end
end