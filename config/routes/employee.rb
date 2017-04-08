require_relative './config.rb'

module EmployeeRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :employee do

        root to: 'home#index'
        
        resources :home, RC::non_restful.merge({:path => ''}) do
          collection do
            post :as
          end
        end

      end
    end
  end
end