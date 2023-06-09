class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_buyer?

  def cart
    @cart = current_user.cart

    if params[:confirmation].present? && @cart.can_checkout?
      render 'confirmation'
    else
      render 'cart'
    end

  end


  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    # do something
    # success?
    cart = current_user.cart
    if cart.complete
      # send email to sellers
      redirect_to order_path(cart.id)
    else
      redirect_to cart_path
    end

  end

end