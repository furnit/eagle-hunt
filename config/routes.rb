require_relative 'routes/config.rb'

Rails.application.routes.draw do

  root to: 'home#index'

  [:category, :furniture].each do |action|
    action = action.to_s
    get "#{action}/:id", to: "home##{action}", as: "home_#{action}"
  end

  post 'furniture/notify', to: 'home#furniture_notify', as: 'home_furniture_notify', **RC::json_request_only.merge({constraints: lambda { |request| request.xhr? }})

  get 'contact/us/:section', to: 'home#contactus', as: 'contact_us'

  # only to create/delete shopping carts and only excepts JSON format
  resources :shopping_carts, RC::ajax_server.merge(RC::json_request_only).merge({only: [:create, :update]})

  resources :profiles

  resources :api, RC::non_restful do
    collection do
      post :ls_fabrics, RC::ajax_server.merge(RC::json_request_only)
      post :transit_price, RC::ajax_server.merge(RC::json_request_only)
      post :ls_fabric_models, RC::ajax_server.merge(RC::json_request_only)
    end
  end

  namespace :order do
    resources :orders do
      member do
        post :submit_simple, RC::ajax_server.merge(RC::json_request_only)
        get :simple
        get :advance
        scope :advance do
          # create routes on advance steps ordering
          post "step/:step_id", action: "advance_steps", as: :advance_steps
        end
      end
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get "users/sign_in/verify"   => "users/sessions#verify"
    patch "users/sign_in/confirm"  => "users/sessions#confirm"

    get "users/password/confirm" => "users/passwords#confirm"
    patch "users/password/reset" => "users/passwords#reset"
  end
end
