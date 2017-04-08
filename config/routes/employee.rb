require_relative './config.rb'

module AdminRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :employee do

        root to: 'home#index'

      end
    end
  end
end