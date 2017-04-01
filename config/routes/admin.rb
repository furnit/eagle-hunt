require_relative './config.rb'

module AdminRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :admin do

        root to: 'home#index'

        resources :users
        resources :user_types

        resources :home, RC::non_restful.merge({:path => ''}) do
          collection do
            get :dashboard
            delete :user_block
          end
        end

      end
    end
  end
end