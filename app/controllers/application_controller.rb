class ApplicationController < ActionController::Base

  def not_found
    render "not_found"
  end

  def is_shop?
    if current_user.present?
      @shop = current_user.shop
    end

    unless @shop.present?
      return respond_to do |format|
        format.html { redirect_to products_url(), notice: "You need to own a shop to create products" }
      end
    end
  end

end

