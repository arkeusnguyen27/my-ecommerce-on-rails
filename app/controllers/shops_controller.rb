class ShopsController < ApplicationController

  def index
    @shops = get_shops.values
  end

  def show
    @shop = shop_params or not_found
  end

  def update
  end



  private
  def shop_params
    shop_id = params[:shop_id].to_i
    get_shops[shop_id]
  end
end
