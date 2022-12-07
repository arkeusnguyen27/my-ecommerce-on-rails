Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }


  resources :dashboard, only: [:index] do
    collection do
      resources :products, only: [:new, :create, :edit, :update], controller: 'seller_products', as: 'seller_products'
      # resources :orders, only: [:new, :create, :edit], controller: 'seller_orders'
      get ':view_param', to: 'dashboard#index', as: "dashboard_view"
    end
  end  
  root "home#landing"

  get "/about-us", to: "home#about_us"
  get "/apps", to: "home#apps"
  get "/pricing", to: "home#pricing"
  get "/search", to: "home#search"


  resources :shops, only: [:show, :index] do
    resources :products, only: [:show, :index, :edit, :update]
  end

  put '/api/toggle_featured_products', to: "dashboard#toggle_featured_products"
end
