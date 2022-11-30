Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :products

  resources :dashboard, only: [:index] do
    collection do
      get ':view_param', to: 'dashboard#index', as: "dashboard_view"
    end
  end  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#landing"

  get "/about-us", to: "home#about_us"
  get "/apps", to: "home#apps"
  get "/pricing", to: "home#pricing"


  # shops
  get "/shops", to: "shops#index", as: :shops
  get "/shops/:shop_id", to: "shops#show", as: :shop
  # shops / products

  # buyers dashboard

  # sellers dashboard

  # admin dashboard

end
