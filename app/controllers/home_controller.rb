class HomeController < ApplicationController
  def landing

  end

  def about_us
  end

  def apps
  end

  def pricing
  end

  def search
    @q = Product.public_products.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  private
  def home_params

  end
end
