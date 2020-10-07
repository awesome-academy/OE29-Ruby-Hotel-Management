Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :account_activations, only: [:edit]
    resources :reservations
    resources :bookings
    namespace :admin do
      root "dashboard#index"
      resources :views, except: %i(new show)
      resources :users
      resources :types, except: %i(new show)
      resources :unities, except: %i(new show)
      resources :services, except: %i(new show)
      resources :rooms, except: :new
      resources :pictures, only: :destroy
    end
  end
  # match "*unmatched", to: "application#render_404", via: :all
end
