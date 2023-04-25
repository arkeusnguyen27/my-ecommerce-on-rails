require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  devise_for :users, controllers: { registrations: 'users/registrations' }


  resources :dashboard, only: [:index] do
    collection do
      resources :products, only: [:new, :create, :edit, :update, :destroy], controller: 'seller_products', as: 'seller_products'
      # resources :orders, only: [:new, :create, :edit], controller: 'seller_orders'
      get ':view_param', to: 'dashboard#index', as: "dashboard_view"
      resources :blogs,  only: [:index, :new, :create, :edit, :update, :destroy], controller: 'user_blog', as: 'user_blog'
    end
  end  
  root "home#landing"

  get "/about-us", to: "home#about_us"
  get "/apps", to: "home#apps"
  get "/pricing", to: "home#pricing"
  get "/search", to: "home#search"

  resources :line_items, only: [:create, :update, :destroy]

  resources :shops, only: [:show, :index] do
    resources :products, only: [:show, :index, :edit, :update]
  end

  resources :orders, only: [:create, :show, :update]

  get "/cart", to: 'orders#cart'

  resources :blogs

  resources :reviews, only: [:create]
  post '/reviews_by_email', to: 'reviews#create_by_email', as: 'reviews_by_email'

  get '/sellers/orders/:id', to: 'seller_orders#show', as: 'seller_orders'
  resources :seller_orders, only: [:show, :update]

  get '/products', to: 'products#index'
  put '/api/toggle_featured_products', to: "dashboard#toggle_featured_products"
  put '/api/increase_view_count', to: "blogs#increase_view_count"
end
