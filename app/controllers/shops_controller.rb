class ShopsController < ApplicationController

  def index
    @shops = get_shops.values
  end

  def show
    @shop = shop_params or not_found
    @products = get_products.values.select {|product| product[:shop_id] == @shop[:id]}
  end

  def update
  end

  def pricing
  end


  private
  def shop_params
    shop_id = params[:shop_id].to_i
    get_shops[shop_id]
  end
end
