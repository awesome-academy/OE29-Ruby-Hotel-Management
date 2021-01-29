Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
             controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
    devise_for :users, skip: :omniauth_callbacks, controllers: {

      sessions: "users/sessions",
      registrations: "users/registrations",
    }
    mount API::Base, at: "/"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    resources :account_activations, only: :edit
    resources :rooms, only: %i(index show) do
      resources :comments, only: %i(create destroy)
    end
    resources :reservations
    resources :users
    resources :views
    resources :types
    resources :orders
    resources :bills
    resources :bookings
    resources :rates, only: %i(create update)
    resources :comments, only: %i(create destroy)

    namespace :admin do
      root "dashboard#index"
      get "/bill_history", to: "dashboard#bill_history"
      get "/income_bill", to: "dashboard#income_bill"
      resources :views, except: %i(new show)
      resources :reservations
      resources :users do
        resources :bills do
          resources :bookings
        end
      end
      resources :bookings
      resources :bills
      resources :booking_services
      resources :types, except: %i(new show)
      resources :unities, except: %i(new show)
      resources :services, except: %i(new show)
      resources :rooms, except: :show
    end
  end
  match "*unmatched", to: "application#render_404", via: :all
end
