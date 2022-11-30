class ShopsController < ApplicationController

  def index
    @shops = Shop.all
  end

  def show
    @shop = shop_params or not_found
    @products = @shop.products
  end

  def update
  end



  private
  def shop_params
    shop_id = params[:shop_id].to_i
    Shop.find_by(id: shop_id)
  end
end
