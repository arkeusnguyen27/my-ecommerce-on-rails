Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#landing"

  get "/about-us", to: "home#about_us"
  get "/apps", to: "home#apps"
  get "/pricing", to: "home#pricing"


  # shops
  get "/shops", to: "shops#index", as: :shops
  get "/shops/:shop_id", to: "shops#show", as: :shop
  # shops / products
  get "/shops/:shop_id/products/:product_id", to: "products#show", as: :product

  get "/products", to: "products#index", as: :products
  # buyers dashboard

  # sellers dashboard

  # admin dashboard

end
