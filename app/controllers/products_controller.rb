class ProductsController < ApplicationController

  def index
    @products = get_products.values
  end

  def show
    @product = product_params
  end

  def update
  end

  def pricing
  end

  private

  def product_params
    shop_id = params[:shop_id].to_i
    product_id = params[:product_id].to_i
    product = get_products[product_id]
    return not_found if product[:shop_id] != shop_id
    product
  end
end
