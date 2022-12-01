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
    Shop.friendly.find(params[:id])
  end
end
